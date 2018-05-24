CREATE TRIGGER `slugify` BEFORE INSERT ON `nombres` FOR EACH ROW BEGIN
	declare new_slug varchar(255);  
	declare slug_counter int;
	set slug_counter = 1;
	set new_slug = new.title;
	
	SET new_slug = LOWER(TRIM(new_slug));
	SET new_slug = REPLACE(new_slug, ':', '');
	SET new_slug = REPLACE(new_slug, ')', '');
	SET new_slug = REPLACE(new_slug, '(', '');
	SET new_slug = REPLACE(new_slug, ',', '');
	SET new_slug = REPLACE(new_slug, '.', '');
	SET new_slug = REPLACE(new_slug, "?", '');
	SET new_slug = REPLACE(new_slug, ';', '');
	SET new_slug = REPLACE(new_slug, '&', '');
	SET new_slug = REPLACE(new_slug, '!', '');
	SET new_slug = REPLACE(new_slug, '.', '');
	SET new_slug = REPLACE(new_slug, '&euro;', '');
	SET new_slug = REPLACE(new_slug, 'euro;', '');
	SET new_slug = REPLACE(new_slug, ' ', '-');
	SET new_slug = REPLACE(new_slug, '--', '-');
	SET new_slug = REPLACE(new_slug, '--', '-');
	SET new_slug = REPLACE(new_slug, '--', '-');
	
	SET new.slug = new_slug;

	while exists (select true from test where slug = new.slug) do
		set new.slug = concat(new_slug, '-', slug_counter); 
		set slug_counter = slug_counter + 1;
	end while;
END
;
