-- 题目一（简单）展示电影 ID 为 2116 这部电影各年龄段的平均影评分。
SELECT c.age, avg(b.rate)
FROM t_movie a
JOIN t_rating b ON a.movie_id = b.movie_id
JOIN t_user c ON c.user_id = b.user_id
WHERE a.movie_id = 2116
GROUP BY c.age
ORDER BY c.age;

-- 题目二（中等）找出男性评分最高且评分次数超过 50 次的 10 部电影，展示电影名，平均影评分和评分次数。
select c.movie_name as name, avg(a.rate) as avg_rate, count(c.movie_name) as total
from t_rating a
join t_user b on a.user_id=b.user_id
join t_movie c on a.movie_id=c.movie_id
where b.sex="M"
group by c.movie_name
having total > 50
order by avg_rate desc
limit 10;

-- 题目三（选做）找出影评次数最多的女士所给出最高分的 10 部电影的平均影评分，展示电影名和平均影评分（可使用多行 SQL）。
-- 女性影评次数最多，use_id=1150
select a.user_id
from t_user a
join t_rating b on a.user_id=b.user_id
where a.sex = "F"
group by a.user_id
ORDER BY COUNT(1) DESC limit 1;

-- 评分最高的电影
create table top_ten_movies as
select movie_id, rate from t_rating where user_id = 1150 order by rate desc limit 10;

select b.movie_id as movie_id, c.movie_name as movie_name, avg(b.rate) as avg_rate
from top_ten_movies a
join t_rating b on a.movie_id=b.movie_id
join t_movie c on b.movie_id=c.movie_id
group by b.movie_id,c.movie_name;