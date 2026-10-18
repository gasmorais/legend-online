package cell.mediator.consortiabag
{
   import cell.mediator.DoubleClickMediator;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaBagDoubleClickMediator extends DoubleClickMediator
   {
      
      public function ConsortiaBagDoubleClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(GoodsManager.instance.isSellPos(_cell.data) && _cell.data.bagType == 1)
         {
            return;
         }
         if(_cell.data && _cell.data.templateInfo.SonType != 298)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
         }
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         if(!ConsortiaManager.instance.model.caseBagCanUse)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaBagDoubleClickMediator.operateErrorTips");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:GoodsInfo = _cell.data;
         if(!_loc3_)
         {
            return;
         }
         if(_cell.data && _cell.data.templateInfo.SonType == 298)
         {
            return;
         }
         if(GoodsManager.instance.isSellPos(_loc3_) && _loc3_.bagType == 1)
         {
            return;
         }
         var _loc6_:* = -1;
         var _loc7_:int = 0;
         var _loc4_:int = FrameControllerManager.instance.consortiaController.model.currentCasecellNum;
         _loc6_ = check(_loc4_,_loc3_);
         if(_loc6_ == -1)
         {
            if(_loc4_ <= 56)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  if(!GoodsManager.instance.goodsListByPos.hasOwnProperty(_loc5_ + "_" + 0 + "_" + 6))
                  {
                     _loc6_ = _loc5_;
                     break;
                  }
                  _loc5_++;
               }
            }
            if(_loc6_ == -1)
            {
               _loc6_ = findConsortiaEmputyPos();
            }
         }
         if(_loc6_ != -1)
         {
            PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,6,0,_loc6_,1);
            return;
         }
         _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaBagDoubleClickMediator.command01");
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function findConsortiaEmputyPos() : int
      {
         var _loc2_:int = 0;
         var _loc3_:ConsortiaModel = FrameControllerManager.instance.consortiaController.model;
         var _loc1_:int = 154;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ + 1 > 56)
            {
               if(!(_loc3_.consortiaInfo.isStorageExpire1 && _loc2_ + 1 > 56 && _loc2_ + 1 <= 56 + 49))
               {
                  if(!(_loc3_.consortiaInfo.isStorageExpire2 && _loc2_ + 1 > 56 + 49))
                  {
                     if(!GoodsManager.instance.goodsListByPos[_loc2_ + "_" + 0 + "_" + 6])
                     {
                        return _loc2_;
                     }
                  }
               }
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function check(param1:int, param2:GoodsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc5_:* = FrameControllerManager.instance.consortiaController.model.caseBag;
         _loc4_ = param1 - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = _loc5_.itemList[_loc4_];
            if(_loc3_.data && canSuperposition(_loc3_.data,param2))
            {
               return _loc4_;
            }
            _loc4_--;
         }
         return -1;
      }
      
      private function canSuperposition(param1:GoodsInfo, param2:GoodsInfo) : Boolean
      {
         if(param1.templateId == param2.templateId && param1.templateInfo.MaxCount >= param1.count + param2.count && param1.isBinds == param2.isBinds)
         {
            return true;
         }
         return false;
      }
      
      private function checkStorageMove(param1:int) : Boolean
      {
         if(param1 == 201 || param1 == 203 || param1 == 206)
         {
            return true;
         }
         return false;
      }
   }
}

