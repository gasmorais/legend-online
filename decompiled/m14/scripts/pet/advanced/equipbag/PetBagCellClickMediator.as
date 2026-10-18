package pet.advanced.equipbag
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import mvc.controler.StoreControler;
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetBagCellClickMediator implements IMediator
   {
      
      private var _cell:PetBagCell;
      
      private var godHeadItemTypeDic:SimpleDictionary;
      
      public function PetBagCellClickMediator()
      {
         super();
      }
      
      private function get storeControler() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as PetBagCell;
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
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc21_:* = null;
         var _loc7_:Array = null;
         var _loc17_:Array = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc14_:PetData = null;
         var _loc22_:GoodsInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc15_:String = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc10_:GoodsTemplateInfo = null;
         var _loc19_:int = 0;
         var _loc4_:Boolean = false;
         var _loc18_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:int = 0;
         var _loc12_:int = 0;
         var _loc20_:int = 0;
         var _loc3_:GoodsInfo = _cell.data;
         if(PetEquipManager.currSelectedPage == "PropertyView")
         {
            if(_loc3_.templateInfo.MasterType == 5)
            {
               _loc7_ = GoodsManager.instance.getPetGoodsListById(PetEquipManager.currSelectedPetData.petId).getList();
               _loc17_ = GoodsSonType.getSonTypePos(GoodsInfo(_loc3_).templateInfo.SonType);
               _loc7_.sortOn("pos");
               _loc11_ = 0;
               _loc8_ = -1;
               if(_loc17_.length > 1)
               {
                  for each(var _loc5_:GoodsInfo in _loc7_)
                  {
                     if(_loc5_.templateInfo.SonType == GoodsInfo(_loc3_).templateInfo.SonType && _loc5_.pos == _loc17_[0] + _loc11_)
                     {
                        _loc11_++;
                     }
                  }
                  if(_loc11_ >= _loc17_.length)
                  {
                     _loc8_ = int(_loc17_[0]);
                  }
                  else
                  {
                     _loc8_ = int(_loc17_[_loc11_]);
                  }
               }
               else
               {
                  _loc8_ = int(_loc17_[0]);
               }
               if(_loc8_ != -1)
               {
                  SoundManager.instance.play("024",true);
                  _loc14_ = PetEquipManager.currSelectedPetData;
                  if(!_loc14_.isBind)
                  {
                     dropCell(true,true,_cell,_loc8_,_loc14_.petId);
                     return;
                  }
                  PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,26,0,_loc8_,1,_loc14_.petId);
               }
            }
         }
         else if(PetEquipManager.currSelectedPage == "EquipStoreView")
         {
            if(PetEquipManager.currSelectedView == "PetEquipGodHeadView" && (_cell.data.templateInfo.SonType == 329 || _cell.data.templateInfo.SonType == 343 || _cell.data.templateInfo.SonType == 344))
            {
               _loc22_ = GoodsManager.instance.getHideBagItemByPos(0);
               _loc6_ = PetEquipManager.currGodHeadItem;
               _loc15_ = "";
               if(!_loc6_)
               {
                  _loc15_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellClickMediator.pushEquipToCell");
                  MessageTipManager.instance().show(_loc15_);
                  return;
               }
               godHeadItemTypeDic = new SimpleDictionary();
               _loc2_ = _cell.data.templateInfo;
               _loc4_ = true;
               _loc18_ = -1;
               if(_loc2_.SonType == 329)
               {
                  _loc19_ = int(_loc2_.Property1);
                  godHeadItemTypeDic[_loc19_] = 1;
               }
               else if(_loc2_.SonType == 343)
               {
                  _loc19_ = int(_loc2_.Property1);
                  godHeadItemTypeDic[_loc19_] = 1;
                  _loc19_ = int(_loc2_.Property2);
                  godHeadItemTypeDic[_loc19_] = 1;
               }
               _loc9_ = 1;
               while(_loc9_ < 5)
               {
                  if(_loc6_["join" + _loc9_] == 0)
                  {
                     _loc4_ = false;
                     break;
                  }
                  _loc9_++;
               }
               if(_loc4_)
               {
                  _loc15_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellClickMediator.bagIsFull");
                  MessageTipManager.instance().show(_loc15_);
                  return;
               }
               _loc13_ = 1;
               while(_loc13_ < 5)
               {
                  _loc16_ = int(_loc6_["join" + _loc13_]);
                  if(_loc16_ > 0)
                  {
                     _loc10_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc16_);
                     if(_loc10_.SonType == _loc2_.SonType)
                     {
                        if(_loc10_ && (_loc10_.SonType == 343 || _loc10_.SonType == 344) && _loc2_.Property1 == _loc10_.Property1 && _loc2_.Property2 == _loc10_.Property2)
                        {
                           _loc15_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                           MessageTipManager.instance().show(_loc15_);
                           return;
                        }
                        if(_loc10_ && _loc10_.SonType == 329 && _loc2_.Property1 == _loc10_.Property1)
                        {
                           _loc15_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipGodHeadView.JoinGem");
                           MessageTipManager.instance().show(_loc15_);
                           return;
                        }
                     }
                     if(_loc10_.SonType == 329)
                     {
                        _loc19_ = int(_loc10_.Property1);
                        if(godHeadItemTypeDic[_loc19_])
                        {
                           godHeadItemTypeDic[_loc19_]++;
                           if(godHeadItemTypeDic[_loc19_] > 2 && _loc18_ == -1)
                           {
                              _loc18_ = _loc19_;
                           }
                        }
                        else
                        {
                           godHeadItemTypeDic[_loc19_] = 1;
                        }
                     }
                     else if(_loc10_.SonType == 343)
                     {
                        _loc19_ = int(_loc10_.Property1);
                        if(godHeadItemTypeDic[_loc19_])
                        {
                           godHeadItemTypeDic[_loc19_]++;
                           if(godHeadItemTypeDic[_loc19_] > 2 && _loc18_ == -1)
                           {
                              _loc18_ = _loc19_;
                           }
                        }
                        else
                        {
                           godHeadItemTypeDic[_loc19_] = 1;
                        }
                        _loc19_ = int(_loc10_.Property2);
                        if(godHeadItemTypeDic[_loc19_])
                        {
                           godHeadItemTypeDic[_loc19_]++;
                           if(godHeadItemTypeDic[_loc19_] > 2 && _loc18_ == -1)
                           {
                              _loc18_ = _loc19_;
                           }
                        }
                        else
                        {
                           godHeadItemTypeDic[_loc19_] = 1;
                        }
                     }
                  }
                  _loc13_++;
               }
               _loc12_ = 1;
               while(_loc12_ < 5)
               {
                  _loc20_ = int(_loc6_["join" + _loc12_]);
                  if(_loc20_ == 0)
                  {
                     control.sendItemMount(_loc12_,_cell.data.pos,_cell.data.bagType);
                     return;
                  }
                  _loc12_++;
               }
            }
            else if(_cell.data.templateInfo.SonType != 328)
            {
               if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView" && _cell.data.templateInfo.StrengthenMax > _cell.data.mouldGrade)
               {
                  _loc15_ = LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt_01");
                  MessageTipManager.instance().show(_loc15_);
                  return;
               }
               if(_cell.data.objectId > 0)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,1,PetEquipManager.currSelectedPetData.petId);
               }
               else
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,1);
               }
            }
         }
      }
      
      private function dropCell(param1:Boolean, param2:Boolean, param3:BaseItemView, param4:int, param5:int) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,26,0,param4,1,param5);
         }
      }
      
      private function dropCell2(param1:Boolean, param2:Boolean, param3:BaseItemView) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,1);
         }
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
   }
}

