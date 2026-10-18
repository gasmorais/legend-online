package battle.skillsys.ripple
{
   import battle.BattleManager;
   import battle.skillsys.mode.ActionTemplateData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import flash.display.MovieClip;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class RipplePreCreater
   {
      
      private static var resArr:Array = [];
      
      public function RipplePreCreater()
      {
         super();
      }
      
      public static function create(param1:Array, param2:Function) : Array
      {
         var _loc8_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc5_:ActionTemplateData = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return [];
         }
         var _loc3_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc8_ = int(param1[_loc6_]);
            if(_loc8_ != 0 && _loc8_ != -1)
            {
               _loc7_ = TempleteManager.instance.getSkillTemplateInfoById(_loc8_);
               if(_loc7_)
               {
                  _loc5_ = TempleteManager.instance.actionTemplate2[_loc7_.ActionId];
                  if(_loc5_ && _loc5_.presentType == 2)
                  {
                     for each(var _loc9_:SkillFrameData in _loc5_.frames)
                     {
                        if(_loc9_.shootData)
                        {
                           _loc4_ = _loc9_.shootData.rippleRes;
                           if(_loc4_ && _loc4_ != "")
                           {
                              if(resArr.indexOf(_loc4_) == -1)
                              {
                                 resArr.push(_loc4_);
                                 createOne(_loc4_);
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
         return resArr;
      }
      
      public static function addRippleId(param1:String) : void
      {
         if(resArr.indexOf(param1) == -1)
         {
            resArr.push(param1);
         }
      }
      
      private static function createOne(param1:String) : void
      {
         var _loc3_:MovieClip = BattleManager.getInstance().resourceModel.getOrCreateInstanse(param1) as MovieClip;
         var _loc2_:SimpleBitmapMovieClip = new SimpleBitmapMovieClip(_loc3_,param1,true,false);
         _loc2_.stop();
         _loc2_.dispose();
      }
      
      public static function clear() : void
      {
         for each(var _loc1_:String in resArr)
         {
            SimpleBitmapMovieClip.disposeBitmapMovieClip(_loc1_);
         }
         resArr = [];
         SimpleBitmapMovieClip.disposeAllCache();
      }
   }
}

