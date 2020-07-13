<?php
/**
 * This file is part of the Divergence package.
 *
 * (c) Henry Paradiz <henry.paradiz@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
namespace technexus\Controllers;

use \technexus\App as App;
use Divergence\Responders\Response;
use \technexus\Responders\TwigBuilder;
use Divergence\IO\Database\MySQL as DB;
use Psr\Http\Message\ResponseInterface;
use \technexus\Models\BlogPost as BlogPost;
use \technexus\Models\PostTags as PostTags;
use Psr\Http\Message\ServerRequestInterface;

/**
 * Main Blog controller
 */
class Blog extends \Divergence\Controllers\RequestHandler
{
    /**
     * Handles main routing
     * @return mixed
     */
    public function handle(ServerRequestInterface $request): ResponseInterface
    {
        switch ($action = $this->shiftPath()) {
            case 'admin':
                return (new Admin())->handle($request);
                
            case 'api':
                return (new API())->handle($request);

            case 'media':
                return (new Media())->handle($request);
                
            case 'logout':
                return $this->logout();
                    
            case '':
                return $this->home();
                break;

            case 'topics':
                return $this->topics();

            case ctype_digit($action):
                // year of posts
                if (strlen($action) == 4) {
                    $year = $action;
                }
                // month of posts
                if (ctype_digit($this->peekPath()) && strlen($this->peekPath()) == 2) {
                    $month = $this->shiftPath();
                }
                // single post
                if ($this->peekPath()) {
                    $permalink = $this->shiftPath();
                }
                
                if (!$permalink && !$month) {
                    return $this->year($year);
                }
                
                if (!$permalink) {
                    return $this->month($year, $month);
                }
                
                return $this->post($year, $month, $permalink);
                
            default:
                $error = new Errors();
                return $error->handle($request);
        }
    }

    /**
     * Gets stuff that goes into the sidebar. All Months with blog posts and tags ordered by the amount of times that tag was used.
     *
     * @link project://views/blog/sidebar.twig
     * @return array
     */
    public function getSidebarData()
    {
        return [
            'Months' => DB::AllRecords(sprintf('SELECT DISTINCT MONTHNAME(`Created`) as `MonthName`,MONTH(`Created`) as `Month`, YEAR(`Created`) as `Year` FROM `%s` ORDER BY `Created` DESC', BlogPost::$tableName)),
            'Tags' => PostTags::getAllbyQuery('SELECT *,COUNT(*) as `Count` FROM `'.PostTags::$tableName.'` GROUP BY `TagID` ORDER BY `Count` DESC'),
        ];
    }
    
    /**
     * Returns conditions for which blog posts to display
     *
     * @return array
     */
    public function conditions()
    {
        if (App::$App->is_loggedin()) {
            return [
                "`Status` IN ('Draft','Published')",
            ];
        } else {
            return [
                "`Status` IN ('Published')",
            ];
        }
    }

    /**
     * Displays main home page.
     *
     * @link project://views/blog/posts.twig
     * @link project://views/templates/post.twig
     */
    public function home(): ResponseInterface
    {
        $BlogPosts = BlogPost::getAllByWhere(array_merge($this->conditions(), [
            
        ]), [
            'order' =>  'Created DESC',
        ]);
        
        return new Response(new TwigBuilder('blog/posts.twig', [
            'BlogPosts' => $BlogPosts,
            'Sidebar' => $this->getSidebarData(),
        ]));
    }
    
    /**
     * Displays a given year of blog posts
     *
     * @param string $year
     * @link project://views/blog/posts.twig
     * @link project://views/templates/post.twig
     */
    public function year($year): ResponseInterface
    {
        $BlogPosts = BlogPost::getAllByWhere(array_merge($this->conditions(), [
            sprintf('YEAR(`Created`)=%d', $year),
        ]), [
            'order' =>  'Created DESC',
        ]);
        
        
        return new Response(new TwigBuilder('blog/posts.twig', [
            'BlogPosts' => $BlogPosts,
            'Sidebar' => $this->getSidebarData(),
        ]));
    }
    
    /**
     * Displays a month of blogs
     *
     * @param string $year
     * @param string $month
     * @link project://views/blog/posts.twig
     * @link project://views/templates/post.twig
     * @return void
     */
    public function month($year, $month)
    {
        $BlogPosts = BlogPost::getAllByWhere(array_merge($this->conditions(), [
            sprintf('YEAR(`Created`)=%d', $year),
            sprintf('MONTH(`Created`)=%d', $month),
        ]), [
            'order' =>  'Created DESC',
        ]);
        
        return new Response(new TwigBuilder('blog/posts.twig', [
            'BlogPosts' => $BlogPosts,
            'Sidebar' => $this->getSidebarData(),
        ]));
    }
    
    /**
     * Displays a blog post
     *
     * @param string $year
     * @param string $month
     * @param string $permalink
     * @link project://views/blog/post.twig
     * @link project://views/templates/post.twig
     * @return void
     */
    public function post($year, $month, $permalink)
    {
        $BlogPost = BlogPost::getByWhere(array_merge($this->conditions(), [
            sprintf('YEAR(`Created`)=%d', $year),
            sprintf('MONTH(`Created`)=%d', $month),
            "`permalink`='".DB::escape($permalink)."'",
        ]));
        
        return new Response(new TwigBuilder('blog/post.twig', [
            'BlogPost' => $BlogPost,
            'Sidebar' => $this->getSidebarData(),
        ]));
    }
    
    /**
     * Displays blog posts by tag.
     *
     * @link project://views/blog/post.twig
     * @link project://views/templates/post.twig
     * @return void
     */
    public function topics()
    {
        if ($this->peekPath()) {
            if (App::$App->is_loggedin()) {
                $where = "`Status` IN ('Draft','Published')";
            } else {
                $where = "`Status` IN ('Published')";
            }
            if ($Tag = \technexus\Models\Tag::getByField('Slug', urldecode($this->shiftPath()))) {
                $BlogPosts = BlogPost::getAllByQuery(
                    "SELECT `bp`.* FROM `%s` `bp`
					INNER JOIN %s as `t` ON `t`.`BlogPostID`=`bp`.`ID`
					WHERE `t`.`TagID`='%s' AND $where",
                    [
                        BlogPost::$tableName,
                        PostTags::$tableName,
                        $Tag->ID,
                    ]
                );
                    
                return new Response(new TwigBuilder('blog/posts.twig', [
                    'Title' => $Tag->Tag,
                    'BlogPosts' => $BlogPosts,
                    'Sidebar' => static::getSidebarData(),
                ]));
            }
        }
    }
    
    /**
     * Removes the user from the session and redirects to the homepage.
     *
     * @return void
     */
    public static function logout()
    {
        if (App::$Session->CreatorID) {
            App::$Session->CreatorID = null;
            App::$Session->save();
        }
        header('Location: /');
        exit;
    }
}
