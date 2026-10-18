package com.speedEngine.res.loader
{
   import com.speedEngine.components.model.MovieData2D;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.BaseLoader;
   import com.speedEngine.res.QueueLoader;
   
   use namespace basegame_internal;
   
   public class MovieLoader extends QueueLoader
   {
      
      private var _movieData:Object;
      
      private var _is3D:Boolean = true;
      
      private var _isAtf:Boolean = false;
      
      public function MovieLoader(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super();
         _path = param1;
         _isAtf = param3;
         _is3D = param2;
         if(!param2)
         {
            _movieData = new MovieData2D();
            _movieData.atlasType = "tex_atlas";
            addLoader(new BitmapLoader(picPath));
         }
         addLoader(new DataLoader(dataPath,true));
      }
      
      public function get movieData() : Object
      {
         return _movieData;
      }
      
      public function get dataPath() : String
      {
         return path + ".mc";
      }
      
      public function get picPath() : String
      {
         return path + (isAtf ? ".atf" : ".png");
      }
      
      override public function signalCompleteChild(param1:BaseLoader) : void
      {
         if(param1.path.indexOf(".mc") != -1)
         {
            _movieData.meta = JSON.parse(param1["data"] as String);
         }
         else
         {
            _movieData.atlas = _is3D ? param1["texture"] : param1["bitmapData"];
         }
         if(_movieData.meta && _movieData.atlas)
         {
            _movieData.url = path;
            _movieData.build();
         }
         super.signalCompleteChild(param1);
      }
      
      public function get isAtf() : Boolean
      {
         return _isAtf;
      }
   }
}

