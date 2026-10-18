package pet.advanced.equipbag
{
   import bag.datas.GoodsSonType;
   import cell.mediator.CellDropMediator;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import mvc.controler.StoreControler;
   import mvc.module.pet.PetData;
   import pet.equipstore.godhead.GodHeadItemView;
   import pet.equipstore.streng.PetEquipStrengItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetBagCellDropMediator extends CellDropMediator
   {
      
      private var godHeadItemTypeDic:SimpleDictionary;
      
      public function PetBagCellDropMediator()
      {
         super();
      }
      
      private function get storeControler() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
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
         _loc2_.dropChecks = [PetEquipCell,GodHeadItemView,PetEquipStrengItem,Frame,Stage];
         _cell.setGrayFilter();
         NotificationManager.instance.sendNotification("PETEQUIPDROPSTART",_cell.data);
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc19_:BaseItemView = null;
         var _loc14_:int = 0;
         var _loc20_:PetData = null;
         var _loc13_:int = 0;
         var _loc21_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc10_:GoodsInfo = null;
         var _loc11_:GodHeadItemView = null;
         var _loc22_:int = 0;
         var _loc9_:int = 0;
         var _loc18_:Boolean = false;
         var _loc24_:int = 0;
         var _loc12_:GoodsTemplateInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc25_:GoodsInfo = null;
         var _loc23_:String = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc16_:SimpleDictionary = null;
         var _loc15_:int = 0;
         var _loc17_:int = 0;
         NotificationManager.instance.sendNotification("PETEQUIPDROPOVER");
         if(!_cell.data || !_cell.data.templateInfo)
         {
            param1.stopImmediatePropagation();
            _cell.setNormalFilter();
            return;
         }
         var _loc8_:GoodsTemplateInfo = _cell.data.templateInfo;
         if(param1.dropTarget is PetEquipCell)
         {
            _loc19_ = param1.dropTarget as BaseItemView;
            _loc20_ = PetEquipManager.currSelectedPetData;
            if(_loc20_)
            {
               _loc13_ = int(_loc20_.petId);
               _loc21_ = "";
               if(!_loc20_.isBind)
               {
                  dropCell(true,true,_cell,_loc19_,_loc13_);
                  _cell.setNormalFilter();
                  return;
               }
               if(!_cell.data.isBinds)
               {
                  SimpleAlertHelper.instance.data = [dropCell,_cell,_loc19_,_loc13_];
                  _loc6_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc7_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc5_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc2_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt03");
                  SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc6_,_loc7_,true,false,false,2);
                  _cell.setNormalFilter();
                  return;
               }
               dropCell(true,true,_cell,_loc19_,_loc13_);
            }
         }
         else if(param1.dropTarget is PetEquipStrengItem)
         {
            if(_loc8_.MasterType != 5)
            {
               _loc21_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.typeError");
               MessageTipManager.instance().show(_loc21_);
               _cell.setNormalFilter();
               return;
            }
            _loc19_ = param1.dropTarget as BaseItemView;
            if(_cell.data.objectId > 0)
            {
               if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView" && _cell.data.templateInfo.StrengthenMax > _cell.data.mouldGrade)
               {
                  _loc21_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt_01");
                  MessageTipManager.instance().show(_loc21_);
                  _cell.setNormalFilter();
                  return;
               }
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,_loc19_.bagType,_loc19_.objectId,_loc19_.pos,1,PetEquipManager.currSelectedPetData.petId);
            }
            else
            {
               if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView" && _cell.data.templateInfo.StrengthenMax > _cell.data.mouldGrade)
               {
                  _loc21_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt_01");
                  MessageTipManager.instance().show(_loc21_);
                  _cell.setNormalFilter();
                  return;
               }
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,_loc19_.bagType,_loc19_.objectId,_loc19_.pos,1);
            }
            NotificationManager.instance.sendNotification("PETEQUIPDROPOVER");
            param1.stopImmediatePropagation();
         }
         else if(param1.dropTarget is GodHeadItemView)
         {
            _loc10_ = GoodsManager.instance.getHideBagItemByPos(0);
            if(_loc8_.SonType != 329 && _loc8_.SonType != 343 && _loc8_.SonType != 344)
            {
               _loc21_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.typeError2");
               MessageTipManager.instance().show(_loc21_);
               _cell.setNormalFilter();
               return;
            }
            _loc11_ = param1.dropTarget as GodHeadItemView;
            if(_loc11_.state == 2)
            {
               godHeadItemTypeDic = new SimpleDictionary();
               _loc22_ = -1;
               _loc18_ = true;
               _loc24_ = -1;
               _loc3_ = _cell.data.templateInfo;
               _loc25_ = PetEquipManager.currGodHeadItem;
               _loc23_ = "";
               if(_loc25_)
               {
                  if(_loc3_.SonType == 329)
                  {
                     _loc9_ = int(_loc3_.Property1);
                     godHeadItemTypeDic[_loc9_] = 1;
                  }
                  else if(_loc3_.SonType == 343)
                  {
                     _loc9_ = int(_loc3_.Property1);
                     godHeadItemTypeDic[_loc9_] = 1;
                     _loc9_ = int(_loc3_.Property2);
                     godHeadItemTypeDic[_loc9_] = 1;
                  }
                  if(_loc25_["join" + _loc11_.pos] > 0)
                  {
                     _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc25_["join" + _loc11_.pos]);
                     _loc16_ = new SimpleDictionary();
                     _loc16_ = godHeadItemTypeDic;
                     _loc15_ = 1;
                     while(_loc15_ < 5)
                     {
                        _loc24_ = int(_loc25_["join" + _loc15_]);
                        if(_loc24_ > 0)
                        {
                           if(_loc24_ == _loc25_["join" + _loc11_.pos])
                           {
                              _loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc24_);
                              if(_loc12_.SonType == 329)
                              {
                                 _loc9_ = int(_loc12_.Property1);
                                 godHeadItemTypeDic[_loc9_]--;
                              }
                              else if(_loc12_.SonType == 343)
                              {
                                 _loc9_ = int(_loc12_.Property1);
                                 godHeadItemTypeDic[_loc9_]--;
                                 _loc9_ = int(_loc12_.Property2);
                                 godHeadItemTypeDic[_loc9_]--;
                              }
                           }
                           _loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc24_);
                           if((_loc3_.SonType == 343 || _loc3_.SonType == 344) && _loc12_.Property1 == _loc3_.Property1 && _loc12_.Property2 == _loc3_.Property2 && _loc3_.SonType == _loc12_.SonType)
                           {
                              _loc23_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                              MessageTipManager.instance().show(_loc23_);
                              _cell.setNormalFilter();
                              return;
                           }
                           if(_loc3_.SonType == 329 && _loc12_.Property1 == _loc3_.Property1 && _loc3_.SonType == _loc12_.SonType)
                           {
                              _loc23_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                              MessageTipManager.instance().show(_loc23_);
                              _cell.setNormalFilter();
                              return;
                           }
                           if(_loc12_.SonType == 329)
                           {
                              _loc9_ = int(_loc12_.Property1);
                              if(godHeadItemTypeDic[_loc9_])
                              {
                                 godHeadItemTypeDic[_loc9_]++;
                                 if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                 {
                                    _loc22_ = _loc9_;
                                 }
                              }
                              else
                              {
                                 godHeadItemTypeDic[_loc9_] = 1;
                              }
                           }
                           else if(_loc12_.SonType == 343)
                           {
                              _loc9_ = int(_loc12_.Property1);
                              if(godHeadItemTypeDic[_loc9_])
                              {
                                 godHeadItemTypeDic[_loc9_]++;
                                 if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                 {
                                    _loc22_ = _loc9_;
                                 }
                              }
                              else
                              {
                                 godHeadItemTypeDic[_loc9_] = 1;
                              }
                              _loc9_ = int(_loc12_.Property2);
                              if(godHeadItemTypeDic[_loc9_])
                              {
                                 godHeadItemTypeDic[_loc9_]++;
                                 if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                 {
                                    _loc22_ = _loc9_;
                                 }
                              }
                              else
                              {
                                 godHeadItemTypeDic[_loc9_] = 1;
                              }
                           }
                        }
                        _loc15_++;
                     }
                     _loc16_ = null;
                     _loc4_ = null;
                     control.sendItemMount(_loc11_.pos,_cell.data.pos,_cell.data.bagType);
                  }
                  else
                  {
                     _loc17_ = 1;
                     while(_loc17_ < 5)
                     {
                        _loc24_ = int(_loc25_["join" + _loc17_]);
                        if(_loc24_ > 0)
                        {
                           _loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc24_);
                           if(_loc3_.SonType == 329 || _loc3_.SonType == 343 || _loc3_.SonType == 344)
                           {
                              if((_loc3_.SonType == 343 || _loc3_.SonType == 344) && _loc12_.Property1 == _loc3_.Property1 && _loc12_.Property2 == _loc3_.Property2 && _loc3_.SonType == _loc12_.SonType)
                              {
                                 _loc23_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                                 MessageTipManager.instance().show(_loc23_);
                                 _cell.setNormalFilter();
                                 return;
                              }
                              if(_loc3_.SonType == 329 && _loc12_.Property1 == _loc3_.Property1 && _loc3_.SonType == _loc12_.SonType)
                              {
                                 _loc23_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                                 MessageTipManager.instance().show(_loc23_);
                                 _cell.setNormalFilter();
                                 return;
                              }
                              if(_loc12_.SonType == 329)
                              {
                                 _loc9_ = int(_loc12_.Property1);
                                 if(godHeadItemTypeDic[_loc9_])
                                 {
                                    godHeadItemTypeDic[_loc9_]++;
                                    if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                    {
                                       _loc22_ = _loc9_;
                                    }
                                 }
                                 else
                                 {
                                    godHeadItemTypeDic[_loc9_] = 1;
                                 }
                              }
                              else if(_loc12_.SonType == 343)
                              {
                                 _loc9_ = int(_loc12_.Property1);
                                 if(godHeadItemTypeDic[_loc9_])
                                 {
                                    godHeadItemTypeDic[_loc9_]++;
                                    if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                    {
                                       _loc22_ = _loc9_;
                                    }
                                 }
                                 else
                                 {
                                    godHeadItemTypeDic[_loc9_] = 1;
                                 }
                                 _loc9_ = int(_loc12_.Property2);
                                 if(godHeadItemTypeDic[_loc9_])
                                 {
                                    godHeadItemTypeDic[_loc9_]++;
                                    if(godHeadItemTypeDic[_loc9_] > 2 && _loc22_ == -1)
                                    {
                                       _loc22_ = _loc9_;
                                    }
                                 }
                                 else
                                 {
                                    godHeadItemTypeDic[_loc9_] = 1;
                                 }
                              }
                           }
                        }
                        _loc17_++;
                     }
                     control.sendItemMount(_loc11_.pos,_cell.data.pos,_cell.data.bagType);
                  }
               }
            }
         }
         else
         {
            param1.stopImmediatePropagation();
            _cell.setNormalFilter();
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[this]);
      }
      
      private function dropCell(param1:Boolean, param2:Boolean, param3:BaseItemView, param4:BaseItemView, param5:int) : void
      {
         var _loc6_:String = null;
         var _loc9_:Array = null;
         var _loc7_:Array = null;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         if(param1)
         {
            _loc6_ = "";
            if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView" && _cell.data.templateInfo.StrengthenMax > _cell.data.mouldGrade)
            {
               _loc6_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt_01");
               MessageTipManager.instance().show(_loc6_);
               _cell.setNormalFilter();
               return;
            }
            if(PetEquipManager.currSelectedPage == "PropertyView")
            {
               _loc9_ = GoodsManager.instance.getPetGoodsListById(PetEquipManager.currSelectedPetData.petId).getList();
               _loc7_ = GoodsSonType.getSonTypePos(GoodsInfo(_cell.data).templateInfo.SonType);
               _loc9_.sortOn("pos");
               _loc11_ = 0;
               _loc10_ = -1;
               _loc12_ = 0;
               while(_loc12_ < _loc7_.length)
               {
                  if(_loc7_[_loc12_] == param4.pos)
                  {
                     _loc10_ = int(param4.pos);
                     PlayerManager.instance.moveBagToBag(param3.data.bagType,param3.data.objectId,param3.data.pos,param4.bagType,0,_loc10_,param3.data.count,param5);
                     return;
                  }
                  _loc12_++;
               }
               if(_loc7_.length > 1)
               {
                  for each(var _loc8_:GoodsInfo in _loc9_)
                  {
                     if(_loc8_.templateInfo.SonType == GoodsInfo(_cell.data).templateInfo.SonType && _loc8_.pos == _loc7_[0] + _loc11_)
                     {
                        _loc11_++;
                     }
                  }
                  if(_loc11_ >= _loc7_.length)
                  {
                     _loc10_ = int(_loc7_[0]);
                  }
                  else
                  {
                     _loc10_ = int(_loc7_[_loc11_]);
                  }
               }
               else
               {
                  _loc10_ = int(_loc7_[0]);
               }
               PlayerManager.instance.moveBagToBag(param3.data.bagType,param3.data.objectId,param3.data.pos,param4.bagType,0,_loc10_,param3.data.count,param5);
            }
            else
            {
               PlayerManager.instance.moveBagToBag(param3.data.bagType,param3.data.objectId,param3.data.pos,param4.bagType,0,param4.pos,param3.data.count,param5);
            }
         }
      }
      
      private function joinGem(param1:Boolean, param2:Boolean, param3:GodHeadItemView, param4:BaseItemView) : void
      {
         var _loc5_:String = null;
         if(param1)
         {
            if(param3.data.templateInfo.Property3 > gold.count)
            {
               _loc5_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.goldNotEnough");
               MessageTipManager.instance().show(_loc5_);
            }
            else
            {
               control.sendItemMount(param3.pos,_cell.data.pos,_cell.data.bagType);
            }
         }
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
   }
}

