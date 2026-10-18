package cell.mediator.storebag
{
   import bag.helper.GoodsCheck;
   import cell.view.storebag.StoreBagCell;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreBagCellClickMediator implements IMediator
   {
      
      private var _cell:StoreBagCell;
      
      private var mountTypeDic:SimpleDictionary;
      
      public function StoreBagCellClickMediator()
      {
         super();
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function get storeControler() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as StoreBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(_cell != null && _cell.data != null && (_cell.bagType == 101 || _cell.bagType == 102))
         {
            return;
         }
         if(_cell.data.isLock && model && model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         if(model && model.selectedPanel == "STORE_PANEL_INTENSIFY" && model.isIntensifing)
         {
            return;
         }
         if(_cell.data.templateId == 2127022 || _cell.data.templateId == 2127026)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var to_pos:int;
         var goods:GoodsInfo;
         var str:String;
         var point:int;
         var itemCount:uint;
         var isResolvePanel:Boolean;
         var moveBagToBag:Function;
         var c:Event = param1;
         if(_cell != null && _cell.data != null && (_cell.bagType == 101 || _cell.bagType == 102))
         {
            NotificationManager.instance.sendNotification("DOUBLE_CLICK",_cell);
            return;
         }
         if(!model || model && StringHelper.isNullOrEmpty(model.selectedPanel))
         {
            NotificationManager.instance.sendNotification("DOUBLE_CLICK",_cell.data);
            return;
         }
         if(!canDoubleClick)
         {
            return;
         }
         if(isMountJewel)
         {
            return;
         }
         SoundManager.instance.play("024",true);
         if(_cell.data.isLock && model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         if(_cell.data.templateInfo.SonType == 204)
         {
            to_pos = 1;
         }
         else
         {
            to_pos = 0;
         }
         if((model.selectedPanel == "STORE_PANEL_REFRESH" || model.selectedPanel == "STORE_PANEL_CAST") && _cell.data.templateInfo.MasterType != 1)
         {
            str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
            MessageTipManager.instance().show(str);
            return;
         }
         if(model.selectedPanel == "STORE_PANEL_SWITCH")
         {
            if(_cell.data.isLock)
            {
               str = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip05");
               MessageTipManager.instance().show(str);
               return;
            }
         }
         if(model.selectedPanel == "STORE_PANEL_ENCHANT")
         {
            if(_cell.data.templateInfo.SonType == 236)
            {
               to_pos = 1;
               goods = GoodsManager.instance.getItemByPOB(0,0,0);
               if(goods == null || canEnchant(goods,_cell.data))
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,to_pos,1);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command06"));
               }
            }
            else if(_cell.data.templateInfo.MasterType == 1)
            {
               to_pos = 0;
               goods = GoodsManager.instance.getItemByPOB(1,0,0);
               if(goods == null || canEnchant(goods,_cell.data))
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,to_pos,1);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command06"));
               }
            }
            return;
         }
         point = isResolePoint;
         if(point == -1 || point == -2)
         {
            return;
         }
         if(model.selectedPanel == "STORE_PANEL_INTENSIFY")
         {
            if(model.isViceIntensifing && to_pos == 1)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
               MessageTipManager.instance().show(str);
               return;
            }
            if(to_pos == 1)
            {
               goods = GoodsManager.instance.getItemByPOB(0,0,0);
               if(goods && goods.templateInfo.NeedChangeJob == 2)
               {
                  if(goods.strengthenGrade >= 36)
                  {
                     if(_cell.data.templateInfo.Property2 != 1)
                     {
                        str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                        MessageTipManager.instance().show(str);
                        return;
                     }
                  }
                  else if(goods.strengthenGrade < 36)
                  {
                     if(_cell.data.templateInfo.Property2 != 0)
                     {
                        str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                        MessageTipManager.instance().show(str);
                        return;
                     }
                  }
               }
               else if(goods && goods.templateInfo.NeedChangeJob != 2 && _cell.data.templateInfo.Property2 != 0)
               {
                  str = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
                  MessageTipManager.instance().show(str);
                  return;
               }
            }
            itemCount = uint(_cell.data.templateInfo.SonType == 228 ? _cell.data.count : 1);
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,to_pos,itemCount);
         }
         else if(model.selectedPanel == "STORE_PANEL_TREASURE_INTENSIFY")
         {
            if(_cell.data.templateInfo.MasterType != 11)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.treasure.command01");
               MessageTipManager.instance().show(str);
               return;
            }
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,to_pos,1);
         }
         else if(model.selectedPanel == "STORE_PANEL_TREASURE_REFRESH")
         {
            if(_cell.data.templateInfo.MasterType != 11)
            {
               str = LanguageMgr.GetTranslation("cell.mediator.storebag.treasure.command01");
               MessageTipManager.instance().show(str);
               return;
            }
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,to_pos,1);
         }
         else
         {
            isResolvePanel = model.selectedPanel == "STORE_PANEL_RESOLVE";
            moveBagToBag = function():void
            {
               if(!(_cell && _cell.data) || isResolvePanel && !storeControler.checkSelectResolveItemValid(_cell.data))
               {
                  return;
               }
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,point,1);
            };
            if(isResolvePanel)
            {
               if(_cell.data.templateInfo.SonType == 218)
               {
                  storeControler.showResolveAlertForMountCard(moveBagToBag);
                  return;
               }
               if(GoodsCheck.isFashion(_cell.data.templateInfo))
               {
                  storeControler.showResolveAlertForFashion(moveBagToBag);
                  return;
               }
               if(_cell.data.strengthenGrade > 0)
               {
                  if(_cell.data.templateInfo.MasterType == 11)
                  {
                     storeControler.showResolveAlertForTreasure(moveBagToBag);
                     return;
                  }
                  storeControler.showResolveAlert(moveBagToBag);
                  return;
               }
            }
            moveBagToBag();
         }
      }
      
      private function canEnchant(param1:GoodsInfo, param2:GoodsInfo) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 == null || param2 == null)
         {
            _loc3_ = true;
         }
         else if(param1.templateInfo.Property2 == param2.templateInfo.SonType || param1.templateInfo.SonType == param2.templateInfo.Property2)
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function get isResolePoint() : int
      {
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            return storeControler.getGoodsPosForRelove(_cell.data);
         }
         return 0;
      }
      
      private function get canDoubleClick() : Boolean
      {
         if(!_cell.data)
         {
            return false;
         }
         if(model.selectedPanel == "STORE_PANEL_COMPOSE")
         {
            return false;
         }
         if(model.selectedPanel == "STORE_PANEL_MOUNT")
         {
            if(_cell.data.templateInfo.SonType == 299)
            {
               return false;
            }
         }
         if(model.selectedPanel == "STORE_PANEL_INTENSIFY" && model.isIntensifing)
         {
            return false;
         }
         return true;
      }
      
      private function get isMountJewel() : Boolean
      {
         var _loc8_:GoodsInfo = null;
         var _loc1_:* = undefined;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:GoodsInfo = _cell.data;
         if(model.selectedPanel == "STORE_PANEL_MOUNT" && (_loc7_.templateInfo.SonType == 205 || _loc7_.templateInfo.SonType == 228))
         {
            _loc8_ = GoodsManager.instance.getHideBagItemByPos(0);
            if(_loc8_)
            {
               _loc1_ = new Vector.<int>();
               if(_loc8_.isViceEquip)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command06");
                  MessageTipManager.instance().show(_loc2_);
                  _loc1_ = null;
                  return true;
               }
               mountTypeDic = new SimpleDictionary();
               _loc4_ = -1;
               if(_loc7_.templateInfo.SonType == 205)
               {
                  _loc5_ = _loc7_.templateInfo.Property1;
                  mountTypeDic[_loc5_] = 1;
               }
               else if(_loc7_.templateInfo.SonType == 228)
               {
                  _loc5_ = _loc7_.templateInfo.Property1;
                  mountTypeDic[_loc5_] = 1;
                  _loc5_ = _loc7_.templateInfo.Property2;
                  mountTypeDic[_loc5_] = 1;
               }
               _loc6_ = 1;
               while(_loc6_ <= 4)
               {
                  if(_loc8_["join" + _loc6_] > 0)
                  {
                     _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc8_["join" + _loc6_]));
                     if(_loc7_.templateInfo.SonType == 205 || _loc7_.templateInfo.SonType == 228)
                     {
                        if(_loc3_.SonType == _loc7_.templateInfo.SonType)
                        {
                           if(_loc3_.SonType == 205 && _loc3_.Property1 == _loc7_.templateInfo.Property1)
                           {
                              _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command03");
                              MessageTipManager.instance().show(_loc2_);
                              _loc1_ = null;
                              return true;
                           }
                           if(_loc3_.SonType == 228 && _loc3_.Property1 == _loc7_.templateInfo.Property1 && _loc3_.Property2 == _loc7_.templateInfo.Property2)
                           {
                              _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command03");
                              MessageTipManager.instance().show(_loc2_);
                              _loc1_ = null;
                              return true;
                           }
                        }
                        if(_loc3_.SonType == 205)
                        {
                           _loc5_ = _loc3_.Property1;
                           if(mountTypeDic[_loc5_])
                           {
                              mountTypeDic[_loc5_]++;
                              if(mountTypeDic[_loc5_] > 2 && _loc4_ == -1)
                              {
                                 _loc4_ = _loc5_;
                              }
                           }
                           else
                           {
                              mountTypeDic[_loc5_] = 1;
                           }
                        }
                        else if(_loc3_.SonType == 228)
                        {
                           _loc5_ = _loc3_.Property1;
                           if(mountTypeDic[_loc5_])
                           {
                              mountTypeDic[_loc5_]++;
                              if(mountTypeDic[_loc5_] > 2 && _loc4_ == -1)
                              {
                                 _loc4_ = _loc5_;
                              }
                           }
                           else
                           {
                              mountTypeDic[_loc5_] = 1;
                           }
                           _loc5_ = _loc3_.Property2;
                           if(mountTypeDic[_loc5_])
                           {
                              mountTypeDic[_loc5_]++;
                              if(mountTypeDic[_loc5_] > 2 && _loc4_ == -1)
                              {
                                 _loc4_ = _loc5_;
                              }
                           }
                           else
                           {
                              mountTypeDic[_loc5_] = 1;
                           }
                        }
                     }
                  }
                  else if(_loc8_["join" + _loc6_] == 0)
                  {
                     _loc1_.push(_loc6_);
                  }
                  _loc6_++;
               }
               if(_loc1_.length <= 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command04");
                  MessageTipManager.instance().show(_loc2_);
                  _loc1_ = null;
                  return true;
               }
               FrameControllerManager.instance.storeController.sendItemMount(_loc1_[0],_loc7_.pos,_loc7_.bagType);
               _loc1_ = null;
            }
            return true;
         }
         return false;
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
   }
}

