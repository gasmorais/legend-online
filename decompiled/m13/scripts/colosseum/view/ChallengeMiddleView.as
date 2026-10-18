package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.ChallengeManager;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   
   public class ChallengeMiddleView extends Sprite implements Disposeable
   {
      
      private var _item0:ChallengeMiddleItem;
      
      private var _item1:ChallengeMiddleItem;
      
      private var _item2:ChallengeMiddleItem;
      
      private var _item3:ChallengeMiddleItem;
      
      private var _item4:ChallengeMiddleItem;
      
      public function ChallengeMiddleView()
      {
         super();
         initView();
         initEvent();
         refreshView(null);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChallengeMiddleItem = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            this["_item" + _loc2_] = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeMiddleItem");
            _loc1_ = this["_item" + _loc2_];
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView(param1:NotificationEvent) : void
      {
         var _loc6_:ThaneInfo = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:ChallengeMiddleItem = null;
         if(!model)
         {
            return;
         }
         var _loc9_:Vector.<ThaneInfo> = model.heroList;
         var _loc2_:ThaneInfo = thane;
         var _loc4_:int = int(model.currentRank);
         _loc2_.challengeRank = _loc4_;
         _loc9_.push(_loc2_);
         var _loc5_:int = int(_loc9_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = _loc9_[_loc7_] as ThaneInfo;
            if(_loc4_ >= _loc6_.challengeRank)
            {
               _loc9_.splice(_loc7_,0,_loc2_);
               break;
            }
            _loc7_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc3_ = this["_item" + _loc8_] as ChallengeMiddleItem;
            _loc3_.data = _loc9_[_loc8_];
            _loc8_++;
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("REFRESH_CHALLENGE",refreshView);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("REFRESH_CHALLENGE",refreshView);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : ColosseumModel
      {
         return ChallengeManager.instance.model;
      }
      
      public function getItemByIdx(param1:int) : ChallengeMiddleItem
      {
         var _loc2_:ChallengeMiddleItem = null;
         var _loc3_:int = 0;
         var _loc4_:ThaneInfo = model.heroList[param1];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = this["_item" + _loc3_] as ChallengeMiddleItem;
            if(_loc2_ && _loc2_.data == _loc4_)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function resize(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         _item0.x = param3 + 90;
         var _loc5_:int = param3 + 90;
         var _loc4_:int = (param1 - 2 * _loc5_) / 4;
         if(_loc4_ <= 200)
         {
            _loc4_ = 200;
         }
         _loc6_ = 1;
         while(_loc6_ < 5)
         {
            this["_item" + _loc6_].x = param3 + 90 + _loc4_ * _loc6_;
            _loc6_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_item0);
         _item0 = null;
         ObjectUtils.disposeViolentMc(_item1);
         _item1 = null;
         ObjectUtils.disposeViolentMc(_item2);
         _item2 = null;
         ObjectUtils.disposeViolentMc(_item3);
         _item3 = null;
         ObjectUtils.disposeViolentMc(_item4);
         _item4 = null;
      }
   }
}

