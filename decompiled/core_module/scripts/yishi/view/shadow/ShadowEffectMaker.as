package yishi.view.shadow
{
   import battle.view.roles.RoleViewBase;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   import yishi.datas.objects.RoleInfo;
   
   public class ShadowEffectMaker
   {
      
      private static var isRunning:Boolean = false;
      
      private static var count:int = 0;
      
      private static var effArr:Array = [];
      
      private static var skipArr:Array = [];
      
      private static var timeOutArr:Array = [];
      
      public function ShadowEffectMaker()
      {
         super();
      }
      
      public static function startPhantom(param1:DisplayObject, param2:int = 2, param3:Number = 0, param4:ColorTransform = null, param5:DisplayObjectContainer = null) : void
      {
         effArr.push(param1);
         skipArr.push([0,param2,param4,param5]);
         timeOutArr.push(param3 ? getTimer() + param3 * 1000 : null);
         param1.filters = [TransformLib.green_glow_filter];
         if(!isRunning)
         {
            StageReferance.stage.addEventListener("enterFrame",showPhantom);
         }
      }
      
      public static function chkEffctObj(param1:DisplayObject) : Boolean
      {
         if(effArr.indexOf(param1) < 0)
         {
            return true;
         }
         return false;
      }
      
      public static function stopPhantom(param1:DisplayObject) : void
      {
         param1.filters = [];
         var _loc2_:int = effArr.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         effArr.splice(_loc2_,1);
         skipArr.splice(_loc2_,1);
         timeOutArr.splice(_loc2_,1);
         if(!effArr.length)
         {
            StageReferance.stage.removeEventListener("enterFrame",showPhantom);
         }
      }
      
      private static function showPhantom(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc5_:RoleViewBase = null;
         var _loc6_:RoleInfo = null;
         var _loc4_:Sprite = null;
         var _loc3_:int = 0;
         try
         {
            if(effArr.length == 0)
            {
               return;
            }
            if(skipArr.length == 0)
            {
               return;
            }
            if(timeOutArr.length == 0)
            {
               return;
            }
            _loc2_ = 0;
            while(_loc2_ < effArr.length)
            {
               skipArr[_loc2_][0]++;
               if(timeOutArr[_loc2_])
               {
                  if(getTimer() >= timeOutArr[_loc2_])
                  {
                     stopPhantom(effArr[_loc2_]);
                     return;
                  }
               }
               _loc5_ = skipArr[_loc2_][3] as RoleViewBase;
               _loc6_ = _loc5_.info;
               _loc4_ = effArr[_loc2_] as Sprite;
               _loc3_ = 7;
               if(_loc6_.moving)
               {
                  _loc3_ = 2;
               }
               count %= _loc3_;
               count = count + 1;
               if(skipArr[_loc2_][0] >= skipArr[_loc2_][1])
               {
                  if(!DisplayObject(effArr[_loc2_]).parent)
                  {
                     stopPhantom(DisplayObject(effArr[_loc2_]));
                     return;
                  }
                  ShadowCue.addOne(DisplayObject(effArr[_loc2_]),skipArr[_loc2_][2],skipArr[_loc2_][3]);
                  skipArr[_loc2_][0] = 0;
               }
               _loc2_++;
            }
         }
         catch(err:Error)
         {
            trace(err.message);
            trace(err.getStackTrace());
         }
      }
      
      public static function stopAll() : void
      {
         effArr.length = 0;
         skipArr.length = 0;
         timeOutArr.length = 0;
         isRunning = false;
         count = 0;
         StageReferance.stage.removeEventListener("enterFrame",showPhantom);
      }
   }
}

