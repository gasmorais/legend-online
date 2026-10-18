package child.equip
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildBagCellDropMediator extends CellDropMediator
   {
      
      public function ChildBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [ChildBagCell,ChildInsetItemView,Frame,Stage];
         _cell.setGrayFilter();
         if(_cell.data.templateInfo.MasterType == 6)
         {
            MsgMan.notifyObserver("ChildEvent.START_DROP",_cell.data);
         }
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc12_:ChildBagCell = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc6_:ChildInsetItemView = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         if(_cell == null)
         {
            NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
            return;
         }
         var _loc9_:ChildBagCell = _cell as ChildBagCell;
         if(_loc9_ == null)
         {
            return;
         }
         MsgMan.notifyObserver("ChildEvent.END_DROP",_loc9_.data);
         if(!_loc9_.data || !_loc9_.data.templateInfo)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childbagcelldrop"));
            param1.stopImmediatePropagation();
            _loc9_.setNormalFilter();
            return;
         }
         var _loc7_:GoodsTemplateInfo = _loc9_.data.templateInfo;
         if(param1.dropTarget is ChildBagCell)
         {
            _loc12_ = param1.dropTarget as ChildBagCell;
            if(_loc9_.data.templateInfo.MasterType == 6)
            {
               if(_loc12_.celltType == "CELL_EQUIP")
               {
                  if(ChildManager.instance.curSelectChild)
                  {
                     if(ChildManager.instance.curSelectChild.growthValue < _loc9_.data.templateInfo.Property3)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("child.equip.ChildBagCellClickMediator.noEnoughGrowth",_loc9_.data.templateInfo.Property3);
                        MessageTipManager.instance().show(_loc2_);
                        param1.stopImmediatePropagation();
                        _loc9_.setNormalFilter();
                        return;
                     }
                     if(_loc9_.data.templateInfo.Job.indexOf(ChildManager.instance.curSelectChild.job + ""))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command01");
                        MessageTipManager.instance().show(_loc2_);
                        param1.stopImmediatePropagation();
                        _loc9_.setNormalFilter();
                        return;
                     }
                     ChildSender.moveBagToBag(_loc9_.data.bagType,_loc9_.data.pos,_loc12_.bagType,_loc12_.pos,ChildManager.instance.curSelectChild.childId);
                  }
               }
               else if(_loc12_.celltType == "CELL_HIDE")
               {
                  if(_loc9_.data.bagType == 30)
                  {
                     if(ChildManager.instance.currSelectedView == "CHILDEQUIPUPGRADEVIEW")
                     {
                        if(_loc9_.data.templateInfo.Profile >= 5 && _loc9_.data.strengthenGrade >= _loc9_.data.templateInfo.StrengthenMax)
                        {
                           MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetAdvancedView.MaxQuality"));
                           _loc9_.setNormalFilter();
                           return;
                        }
                     }
                     if(ChildManager.instance.curSelectChild)
                     {
                        ChildSender.moveBagToBag(_loc9_.data.bagType,_loc9_.data.pos,_loc12_.bagType,0,ChildManager.instance.curSelectChild.childId);
                     }
                  }
                  else
                  {
                     ChildSender.moveBagToBag(_loc9_.data.bagType,_loc9_.data.pos,_loc12_.bagType,0);
                  }
               }
               else if(_loc12_.celltType == "CELL_BOTTOM")
               {
                  if(_loc9_.celltType == "CELL_HIDE")
                  {
                     _loc3_ = int(GoodsManager.instance.findChildEmputyPos());
                     if(_loc3_ == -1)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
                        MessageTipManager.instance().show(_loc2_);
                        param1.stopImmediatePropagation();
                        _loc9_.setNormalFilter();
                        return;
                     }
                     SoundManager.instance.play("024",true);
                     if(ChildManager.instance.curSelectChild)
                     {
                        ChildSender.moveBagToBag(_loc9_.data.bagType,_loc9_.data.pos,28,_loc3_,_loc9_.data.objectId);
                     }
                  }
               }
            }
            param1.stopImmediatePropagation();
            _loc9_.setNormalFilter();
         }
         else if(param1.dropTarget is ChildInsetItemView)
         {
            _loc6_ = param1.dropTarget as ChildInsetItemView;
            if(_loc9_.data.templateInfo.SonType == 224)
            {
               if(!canReplce(_loc9_.data,_loc6_.pos))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem2"));
                  param1.stopImmediatePropagation();
                  _loc9_.setNormalFilter();
                  return;
               }
               if(_loc6_.data)
               {
                  SimpleAlertHelper.instance.data = [__removeJewelCallBack,_loc6_.pos,_loc9_.pos,_loc9_.data.bagType,_loc6_.data.templateInfo.Property3];
                  _loc4_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc5_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc10_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc11_ = LanguageMgr.GetTranslation("store.StoreControler.content",_loc6_.data.templateInfo.Property3);
                  SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc11_,_loc4_,_loc5_);
               }
               else
               {
                  ChildSender.insertJewel(_loc6_.pos,_loc9_.data.pos,_loc9_.data.bagType);
               }
            }
            param1.stopImmediatePropagation();
            _loc9_.setNormalFilter();
         }
         else
         {
            param1.stopImmediatePropagation();
            _loc9_.setNormalFilter();
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
      }
      
      private function __removeJewelCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:String = null;
         if(param1)
         {
            if(gold.count < param6)
            {
               _loc7_ = LanguageMgr.GetTranslation("public.gold");
               MessageTipManager.instance().show(_loc7_);
               return;
            }
            ChildSender.insertJewel(param3,param4,param5);
         }
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      override protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc2_:BaseItemView = BaseItemView(param1.data[0]);
      }
      
      private function canReplce(param1:GoodsInfo, param2:int) : Boolean
      {
         var _loc8_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc3_:Boolean = true;
         var _loc7_:int = int(param1.templateInfo.Property1);
         var _loc5_:GoodsInfo = ChildManager.instance.model.hideGoods;
         _loc6_ = 1;
         while(_loc6_ < 5)
         {
            if(_loc6_ != param2)
            {
               _loc8_ = int(_loc5_["join" + _loc6_]);
               if(_loc8_ > 0)
               {
                  _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_);
                  if(_loc7_ == _loc4_.Property1)
                  {
                     return false;
                  }
               }
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
   }
}

