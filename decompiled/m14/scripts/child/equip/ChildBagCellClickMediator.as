package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import org.aswing.KeyboardManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildBagCellClickMediator implements IMediator
   {
      
      private var _cell:ChildBagCell;
      
      private var _menu:ChildGoodsItemMenu;
      
      public function ChildBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as ChildBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      private function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         var _loc4_:Boolean = Boolean(KeyboardManager.isDown(16));
         if(_loc4_)
         {
            NotificationManager.instance.sendNotification("SEND_GOODS",_cell.data);
            return;
         }
         var _loc5_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         var _loc3_:GoodsInfo = _cell.data;
         var _loc2_:Boolean = Boolean(_loc3_.templateInfo.IsCanBatch);
         if(_cell.data.templateInfo.MasterType == 6 && _cell.celltType == "CELL_ATTRIBE")
         {
            showUseMenu(_loc5_.x + _cell.icon.iconWidth - 10,_loc5_.y + _cell.icon.iconHeight - 10,_cell,_loc2_);
         }
         else
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
         }
      }
      
      private function showUseMenu(param1:int, param2:int, param3:BaseItemView, param4:Boolean) : void
      {
         _menu = ComponentFactory.Instance.creatCustomObject("child.ChildGoodsItemMenu",[param3,param4]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc11_:String = null;
         var _loc2_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc5_:Boolean = false;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc4_:GoodsInfo = _cell.data;
         if(curSelectChild.fightUserId > 0 && curSelectChild.fightUserId != playerInfo.userId)
         {
            if(_cell.celltType != "CELL_HIDE")
            {
               if(ChildManager.instance.currSelectedPage == "CHILD_ATTRIBUTE_PAGE" || ChildManager.instance.currSelectedPage == "CHILD_EQUIP_PAGE" && _cell.data.objectId > 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
                  return;
               }
            }
         }
         if(_loc4_.templateInfo.MasterType == 6)
         {
            if(_cell.celltType == "CELL_EQUIP" || _cell.celltType == "CELL_HIDE")
            {
               _loc2_ = int(GoodsManager.instance.findChildEmputyPos());
               if(_loc2_ == -1)
               {
                  _loc11_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
                  MessageTipManager.instance().show(_loc11_);
                  return;
               }
               SoundManager.instance.play("024",true);
               if(_loc4_.bagType == 30)
               {
                  if(curSelectChild)
                  {
                     ChildSender.moveBagToBag(_loc4_.bagType,_loc4_.pos,28,_loc2_,curSelectChild.childId);
                  }
               }
               else if(curSelectChild)
               {
                  ChildSender.moveBagToBag(_loc4_.bagType,_loc4_.pos,28,_loc2_);
               }
            }
            else if(_cell.celltType == "CELL_BOTTOM")
            {
               if(_loc4_.bagType == 30)
               {
                  if(ChildManager.instance.currSelectedView == "CHILDEQUIPUPGRADEVIEW")
                  {
                     if(_loc4_.templateInfo.Profile >= 5 && _loc4_.strengthenGrade >= _loc4_.templateInfo.StrengthenMax)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetAdvancedView.MaxQuality"));
                        return;
                     }
                  }
                  if(curSelectChild)
                  {
                     ChildSender.moveBagToBag(_loc4_.bagType,_loc4_.pos,29,0,curSelectChild.childId);
                  }
               }
               else
               {
                  ChildSender.moveBagToBag(_loc4_.bagType,_loc4_.pos,29,0);
               }
            }
            else if(_cell.celltType == "CELL_ATTRIBE")
            {
               _loc2_ = getEquipPos(_loc4_);
               if(_loc2_ >= 0)
               {
                  if(_loc4_.templateInfo.Job.indexOf(curSelectChild.job + ""))
                  {
                     _loc11_ = LanguageMgr.GetTranslation("bag.helper.GoodsCheck.command01");
                     MessageTipManager.instance().show(_loc11_);
                  }
                  else
                  {
                     ChildSender.moveBagToBag(28,_loc4_.pos,30,_loc2_,curSelectChild.childId);
                  }
               }
            }
         }
         else if(_loc4_.templateInfo.SonType == 224)
         {
            _loc6_ = model.hideGoods;
            if(!_loc6_)
            {
               _loc11_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellClickMediator.pushEquipToCell");
               MessageTipManager.instance().show(_loc11_);
               return;
            }
            _loc3_ = _loc4_.templateInfo;
            _loc5_ = true;
            _loc7_ = 1;
            while(_loc7_ < 5)
            {
               if(_loc6_["join" + _loc7_] == 0)
               {
                  _loc5_ = false;
                  break;
               }
               _loc7_++;
            }
            if(_loc5_)
            {
               _loc11_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellClickMediator.bagIsFull");
               MessageTipManager.instance().show(_loc11_);
               return;
            }
            _loc10_ = 1;
            while(_loc10_ < 5)
            {
               _loc12_ = int(_loc6_["join" + _loc10_]);
               if(_loc12_ > 0)
               {
                  _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_);
                  if(_loc8_ && _loc3_.Property1 == _loc8_.Property1)
                  {
                     _loc11_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem2");
                     MessageTipManager.instance().show(_loc11_);
                     return;
                  }
               }
               _loc10_++;
            }
            _loc9_ = 1;
            while(_loc9_ < 5)
            {
               _loc13_ = int(_loc6_["join" + _loc9_]);
               if(_loc13_ == 0)
               {
                  ChildSender.insertJewel(_loc9_,_loc4_.pos,_loc4_.bagType);
                  return;
               }
               _loc9_++;
            }
         }
         else if(_loc4_.templateInfo.SonType == 223)
         {
            if(_loc4_.templateInfo.Property2 > 0)
            {
               if(curSelectChild)
               {
                  ChildSender.fosterApt(curSelectChild.childId,_loc4_.pos);
               }
            }
            else if(_loc4_.templateInfo.Property3 > 0)
            {
               if(curSelectChild)
               {
                  ChildSender.fosterMood(curSelectChild.childId,_loc4_.pos);
               }
            }
         }
         else if(_loc4_.templateId == 208042)
         {
            if(curSelectChild)
            {
               ChildSender.useResetGoods(curSelectChild.childId,_loc4_.pos);
            }
         }
      }
      
      private function getEquipPos(param1:GoodsInfo) : int
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:String = null;
         var _loc3_:int = -1;
         if(param1 == null || curSelectChild == null)
         {
            return _loc3_;
         }
         if(curSelectChild.growthValue < param1.templateInfo.Property3)
         {
            _loc2_ = LanguageMgr.GetTranslation("child.equip.ChildBagCellClickMediator.noEnoughGrowth",param1.templateInfo.Property3);
            MessageTipManager.instance().show(_loc2_);
            return _loc3_;
         }
         switch(int(param1.templateInfo.SonType) - 611)
         {
            case 0:
               _loc3_ = 3;
               break;
            case 2:
               _loc3_ = 0;
               break;
            case 3:
               _loc3_ = 2;
               break;
            case 5:
               _loc3_ = 1;
               break;
            case 6:
               _loc4_ = GoodsManager.instance.getItemByPOB(4,curSelectChild.childId,30);
               if(_loc4_ == null)
               {
                  _loc3_ = 4;
               }
               else
               {
                  _loc4_ = GoodsManager.instance.getItemByPOB(5,curSelectChild.childId,30);
                  if(_loc4_ == null)
                  {
                     _loc3_ = 5;
                  }
                  else
                  {
                     _loc3_ = 4;
                  }
               }
               break;
            case 7:
               _loc4_ = GoodsManager.instance.getItemByPOB(6,curSelectChild.childId,30);
               if(_loc4_ == null)
               {
                  _loc3_ = 6;
                  break;
               }
               _loc4_ = GoodsManager.instance.getItemByPOB(7,curSelectChild.childId,30);
               if(_loc4_ == null)
               {
                  _loc3_ = 7;
                  break;
               }
               _loc3_ = 6;
         }
         return _loc3_;
      }
      
      private function get curSelectChild() : ChildData
      {
         return ChildManager.instance.curSelectChild;
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

