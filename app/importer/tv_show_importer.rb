class TvShowImporter
  def self.import(tmdb_id)
    tv_service ||= TvShowDbService.new
    tmdb = tv_service.tv_show(tmdb_id)
    
    tv_show = TvShow.where(tmdb_id: tmdb_id).first_or_initialize

    tv_show.name     = tmdb['name']
    tv_show.overview = tmdb['overview']
    tv_show.homepage = tmdb['homepage']

    tv_show.first_air_date = tmdb['first_air_date']
    tv_show.last_air_date  = tmdb['last_air_date']

    tv_show.poster_path   = tmdb['poster_path']
    tv_show.backdrop_path = tmdb['backdrop_path']

    tv_show.save!

    tmdb['seasons'].each do |s|
      tv_show_season = TvShowSeason.where(tmdb_id: tmdb_id).first_or_initialize
      tv_show_season.tv_show_id = tv_show.id
      tv_show_season.tmdb_id = s['table']['id']
      tv_show_season.number = s['table']['season_number']
      tv_show_season.name = s['table']['name']
      tv_show_season.overview = s['table']['overview']
      tv_show_season.air_date = s['table']['air_date']
      tv_show_season.episode_count = s['table']['episode_count']
      tv_show_season.poster_path = s['table']['poster_path']
      
      tv_show_season.save!
    end

    tv_show
  end
end









