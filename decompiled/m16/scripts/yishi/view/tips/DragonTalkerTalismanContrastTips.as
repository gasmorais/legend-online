package yishi.view.tips
{
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   
   public class DragonTalkerTalismanContrastTips extends BaseTip
   {
      
      private var _talismanTip1:DragonTalkerTalismanTips;
      
      private var _talismanTip2:DragonTalkerTalismanTips;
      
      public function DragonTalkerTalismanContrastTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _talismanTip1 = new DragonTalkerTalismanTips();
         _talismanTip1.y = 25;
         _talismanTip2 = new DragonTalkerTalismanTips();
         _talismanTip2.y = 25;
      }
      
      override public function set direction(param1:int) : void
      {
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               _talismanTip1.x = 0;
               if(_talismanTip2.tipData)
               {
                  _talismanTip2.x = _talismanTip1.x + _talismanTip1.width + 5;
               }
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               _talismanTip1.x = 0;
               if(_talismanTip2.tipData)
               {
                  _talismanTip2.x = 0;
                  _talismanTip1.x = _talismanTip2.x + _talismanTip2.width + 5;
               }
         }
         _talismanTip1.x = Math.round(_talismanTip1.x);
         _talismanTip1.y = Math.round(_talismanTip1.y);
         _talismanTip2.x = Math.round(_talismanTip2.x);
         _talismanTip2.y = Math.round(_talismanTip2.y);
      }
      
      override public function set tipData(param1:Object) : void
      {
         clean();
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:DragonTalkerTalismanInfo = _data as DragonTalkerTalismanInfo;
         addChild(_talismanTip1);
         _talismanTip1.tipData = _loc2_;
         var _loc3_:DragonTalkerTalismanInfo = model.getEquipTalismanInfoBySontype(_loc2_.goodsTempInfo.SonType);
         if(_loc3_ && _loc3_.id != _loc2_.id)
         {
            addChild(_talismanTip2);
            _talismanTip2.tipData = _loc3_;
         }
      }
      
      private function clean() : void
      {
         _talismanTip1.tipData = null;
         _talismanTip2.tipData = null;
         if(_talismanTip1.parent)
         {
            removeChild(_talismanTip1);
         }
         if(_talismanTip2.parent)
         {
            removeChild(_talismanTip2);
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(_talismanTip2)
         {
            _talismanTip2.dispose();
         }
         _talismanTip2 = null;
         if(_talismanTip1)
         {
            _talismanTip1.dispose();
         }
         _talismanTip1 = null;
         super.dispose();
      }
   }
}

