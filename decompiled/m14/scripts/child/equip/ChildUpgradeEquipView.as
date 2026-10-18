package child.equip
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildUpgradeEquipView extends Component
   {
      
      private var _equipBag:ChildEquipBagView;
      
      private var _bg:MutipleImage;
      
      private var _resultImage:ScaleFrameImage;
      
      private var _effectBack:MovieImage;
      
      private var _item1:ChildBagCell;
      
      private var _item2:ChildBagCell;
      
      private var _jewel:BaseItemView;
      
      private var _countTxt:FilterFrameText;
      
      private var _intensifyBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _nameTxt1:FilterFrameText;
      
      private var _nameTxt2:FilterFrameText;
      
      private var _attBox1:VBox;
      
      private var _attBox2:VBox;
      
      private var _addImage1:Image;
      
      private var _addImage2:Image;
      
      private var _currSprite:Sprite;
      
      private var _nextSprite:Sprite;
      
      private var _bmd:BitmapData;
      
      private var _attList:Array;
      
      private var _attNameDic:Dictionary;
      
      private var _intensifyConfigInfo:ConfigInfosTempInfo;
      
      private var _intensifyArr:Array;
      
      private var _shopGoodsInfo:ShopGoodsInfo;
      
      private var _needPoint:int;
      
      private var _hasMaterialCount:int;
      
      private var curType:int = 0;
      
      private var _isShowBox2:Boolean = true;
      
      private var _composeTemp:ComposeGoodsTemplete;
      
      private var _curEvolveTimeStamp:int = 0;
      
      public function ChildUpgradeEquipView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _attList = ["Attack","Defence","MagicAttack","MagicDefence","Live","ForceHit","Parry"];
         _attNameDic = new Dictionary();
         _attNameDic["Attack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         _attNameDic["Defence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         _attNameDic["MagicAttack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         _attNameDic["MagicDefence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         _attNameDic["Live"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _attNameDic["ForceHit"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         _attNameDic["Parry"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         _intensifyConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("MaterialAndCount");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeEquipView.bg");
         _resultImage = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeEquipView.resultImage");
         _item1 = ComponentFactory.Instance.creatCustomObject("ChildUpgradeEquipView.item1",[true]);
         _item2 = ComponentFactory.Instance.creatCustomObject("ChildUpgradeEquipView.item2",[false]);
         _jewel = ComponentFactory.Instance.creatCustomObject("ChildUpgradeEquipView.jewel");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeEquipView.countTxt");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeEquipView.btn");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.btn");
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.nameTxt1");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.nameTxt2");
         _attBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.attBox1");
         _attBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.attBox2");
         _addImage1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.addImage1");
         _addImage2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.addImage2");
         _bmd = ComponentFactory.Instance.creatBitmapData("asset.child.intensifyAddRes");
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeEquipView.EquipSelectedEff");
         _effectBack.mouseChildren = _effectBack.mouseEnabled = false;
         _effectBack.movie.stop();
         _effectBack.visible = false;
         _equipBag = new ChildEquipBagView(2,11);
         _currSprite = new Sprite();
         _nextSprite = new Sprite();
         addChild(_bg);
         addChild(_resultImage);
         addChild(_item1);
         addChild(_item2);
         addChild(_effectBack);
         addChild(_jewel);
         addChild(_countTxt);
         addChild(_intensifyBtn);
         addChild(_upgradeBtn);
         addChild(_nameTxt1);
         addChild(_nameTxt2);
         addChild(_addImage1);
         addChild(_addImage2);
         addChild(_attBox1);
         addChild(_attBox2);
         addChild(_equipBag);
         addChild(_currSprite);
         _currSprite.x = 170;
         _currSprite.y = 108;
         addChild(_nextSprite);
         _nextSprite.x = 445;
         _nextSprite.y = 108;
         _item1.bagType = 29;
         _item1.celltType = "CELL_HIDE";
         _equipBag.x = 6;
         _equipBag.y = 306;
         refreshView();
      }
      
      private function initEvent() : void
      {
         if(_upgradeBtn)
         {
            _upgradeBtn.addEventListener("click",__upgradeClickHandler);
         }
         if(_intensifyBtn)
         {
            _intensifyBtn.addEventListener("click",__intensifyClickHandler);
         }
         MsgMan.addObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.addObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.addObserver("ChildEvent.END_DROP",this,__endDropHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeClickHandler);
         }
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("click",__intensifyClickHandler);
         }
         MsgMan.removeObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.removeObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.removeObserver("ChildEvent.END_DROP",this,__endDropHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagUpdateHandler);
      }
      
      private function __startDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = true;
         _effectBack.movie.play();
      }
      
      private function __endDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = false;
         _effectBack.movie.stop();
      }
      
      private function __bagUpdateHandler(param1:BagEvent) : void
      {
         refreshView();
      }
      
      private function __bagItemUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:ChildEquipAttItem = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc9_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         clean();
         if(model.hideGoods)
         {
            _item1.data = model.hideGoods;
            _nameTxt1.text = model.hideGoods.templateInfo.TemplateName;
            _addImage1.x = _nameTxt1.x + _nameTxt1.textWidth;
            _currSprite.x = _addImage1.x + 15;
            _nameTxt1.y = _nameTxt1.numLines == 1 ? 108 : 102;
            _loc7_ = 0;
            while(_loc7_ < _attList.length)
            {
               if(model.hideGoods.templateInfo[_attList[_loc7_]] && model.hideGoods.templateInfo[_attList[_loc7_]] > 0)
               {
                  _loc6_ = int(model.hideGoods.templateInfo[_attList[_loc7_]]);
                  _loc6_ = _loc6_ + GoodsHelp.getChildEquipStrengAddition(_loc6_,model.hideGoods.strengthenGrade);
                  _loc1_ = new ChildEquipAttItem(false);
                  _loc1_.text = _attNameDic[_attList[_loc7_]] + "+" + _loc6_;
                  _attBox1.addChild(_loc1_);
               }
               _loc7_++;
            }
            if(model.hideGoods.strengthenGrade < model.hideGoods.templateInfo.StrengthenMax)
            {
               curType = 1;
               _loc9_ = model.hideGoods;
               _intensifyBtn.enable = true;
               _upgradeBtn.enable = false;
               _addImage1.visible = true;
               _addImage2.visible = true;
               _currSprite.visible = true;
               _nextSprite.visible = true;
               _isShowBox2 = true;
               _resultImage.setFrame(1);
               _resultImage.width = 202;
               _resultImage.height = 89;
               NumberViewUtils.refreshValue(model.hideGoods.strengthenGrade,_currSprite,_bmd,19,22,12,19,"0123456789");
               NumberViewUtils.refreshValue(model.hideGoods.strengthenGrade + 1,_nextSprite,_bmd,19,22,12,19,"0123456789");
               _intensifyArr = _intensifyConfigInfo.ConfigValue.split("|")[model.hideGoods.templateInfo.Profile - 1].split(",");
               _shopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(int(_intensifyArr[0]));
               _loc3_ = int(_intensifyArr[1]);
               _hasMaterialCount = GoodsManager.instance.getBagCountByTempId(1,int(_intensifyArr[0]));
               if(_shopGoodsInfo)
               {
                  _needPoint = _shopGoodsInfo.price * (_loc3_ - _hasMaterialCount);
               }
               _loc2_ = model.hideGoods.templateInfo;
            }
            else
            {
               curType = 2;
               _composeTemp = model.getComposeTemByGoodsId(model.hideGoods.templateId);
               if(_composeTemp == null)
               {
                  _isShowBox2 = false;
                  _resultImage.setFrame(2);
                  _resultImage.width = 192;
                  _resultImage.height = 41;
               }
               else
               {
                  _upgradeBtn.enable = true;
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = _composeTemp.Material2;
                  _jewel.data = _loc8_;
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = _composeTemp.NewMaterial;
                  _loc8_.pos = -1;
                  _loc8_.userId = _item1.data.userId;
                  _loc8_.isExist = false;
                  _loc8_.objectId = -1;
                  _loc8_.isBinds = true;
                  _loc8_.isUsed = _item1.data.isUsed;
                  _loc8_.isNew = _item1.data.isNew;
                  _loc8_.validDate = _item1.data.validDate;
                  _loc8_.beginDate = _item1.data.beginDate;
                  _loc8_.count = 1;
                  _loc8_.willSellCount = _item1.data.willSellCount;
                  _loc8_.strengthenGrade = 0;
                  _loc8_.join1 = _item1.data.join1;
                  _loc8_.join2 = _item1.data.join2;
                  _loc8_.join3 = _item1.data.join3;
                  _loc8_.join4 = _item1.data.join4;
                  _loc8_.randomSkill1 = _item1.data.randomSkill1;
                  _loc8_.randomSkill2 = _item1.data.randomSkill2;
                  _loc8_.randomSkill3 = _item1.data.randomSkill3;
                  _loc8_.randomSkill4 = _item1.data.randomSkill4;
                  _loc8_.randomSkill5 = _item1.data.randomSkill5;
                  _loc8_.property1 = _item1.data.property1;
                  _countTxt.text = GoodsManager.instance.getBagCountByTempId(1,_composeTemp.Material2) + "/" + _composeTemp.Count2;
                  _item2.data = _loc8_;
                  _loc2_ = _loc8_.templateInfo;
                  _loc9_ = _loc8_;
                  _shopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_composeTemp.Material2);
                  _loc3_ = int(_composeTemp.Count2);
                  _hasMaterialCount = GoodsManager.instance.getBagCountByTempId(1,_composeTemp.Material2);
                  if(_shopGoodsInfo)
                  {
                     _needPoint = _shopGoodsInfo.price * (_loc3_ - _hasMaterialCount);
                  }
               }
            }
            if(_isShowBox2)
            {
               if(_loc2_.Profile >= 1 && _loc2_.Profile <= 5)
               {
                  _resultImage.setFrame(1);
                  _nameTxt1.setFrame(model.hideGoods.templateInfo.Profile);
                  _nameTxt2.setFrame(_loc2_.Profile);
                  _nameTxt2.text = _loc2_.TemplateName;
                  _nameTxt2.y = _nameTxt2.numLines == 1 ? 108 : 102;
                  _addImage2.x = _nameTxt2.x + _nameTxt2.textWidth;
                  _nextSprite.x = _addImage2.x + 15;
                  _loc4_ = new GoodsInfo();
                  _loc5_ = int(curType == 1 ? _intensifyArr[1] : _composeTemp.Count2);
                  _loc4_.templateId = curType == 1 ? _intensifyArr[0] : _composeTemp.Material2;
                  _jewel.data = _loc4_;
                  _countTxt.text = _hasMaterialCount + "/" + _loc5_;
               }
               else
               {
                  _nameTxt1.setFrame(1);
                  _nameTxt2.setFrame(1);
               }
               _loc7_ = 0;
               while(_loc7_ < _attList.length)
               {
                  if(_loc2_ && _loc2_[_attList[_loc7_]] && _loc2_[_attList[_loc7_]] > 0)
                  {
                     _loc1_ = new ChildEquipAttItem(false);
                     _loc6_ = int(_loc2_[_attList[_loc7_]]);
                     if(curType == 1)
                     {
                        _loc1_.upTip = true;
                        _loc6_ += GoodsHelp.getChildEquipStrengAddition(_loc6_,_loc9_.strengthenGrade + 1);
                        _loc1_.text = _attNameDic[_attList[_loc7_]] + "+" + _loc6_;
                        _loc6_ = int(_loc2_[_attList[_loc7_]]);
                        _loc6_ = GoodsHelp.getChildEquipStrengAddition(_loc6_,_loc9_.strengthenGrade + 1) - GoodsHelp.getChildEquipStrengAddition(_loc6_,_loc9_.strengthenGrade);
                        _loc1_.addTxt = "+" + _loc6_;
                     }
                     else
                     {
                        _loc1_.upTip = false;
                        _loc6_ += GoodsHelp.getChildEquipStrengAddition(_loc6_,_loc9_.strengthenGrade);
                        _loc1_.text = _attNameDic[_attList[_loc7_]] + "+" + _loc6_;
                     }
                     _attBox2.addChild(_loc1_);
                  }
                  _loc7_++;
               }
            }
         }
      }
      
      private function clean() : void
      {
         _attBox1.removeAllChild();
         _attBox2.removeAllChild();
         _nameTxt1.text = _nameTxt2.text = "";
         _item1.data = _item2.data = null;
         _jewel.data = null;
         _intensifyBtn.enable = false;
         _upgradeBtn.enable = false;
         _countTxt.text = "";
         _resultImage.setFrame(1);
         _addImage1.visible = false;
         _addImage2.visible = false;
         _currSprite.visible = false;
         _nextSprite.visible = false;
      }
      
      private function __upgradeClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(curSelectChild)
         {
            if(model.hideGoods == null)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellDropMediator.command01"));
               return;
            }
            if(model.hideGoods.templateInfo.Profile >= 5)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetAdvancedView.MaxQuality"));
               return;
            }
            if(model.hideGoods.strengthenGrade < model.hideGoods.templateInfo.StrengthenMax)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("pet.advanced.equipbag.PetBagCellDropMediator.prompt_01"));
               return;
            }
            if(_needPoint <= 0)
            {
               upgradeResultHandler(true,true);
            }
            else
            {
               SimpleAlertHelper.instance.data = [upgradeResultHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("child.equip.ChildUpgradeEquipView.upgradeContent",_needPoint);
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert");
            }
         }
      }
      
      private function upgradeResultHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc3_ >= _needPoint || _hasMaterialCount >= _composeTemp.Count2)
         {
            _loc4_ = param2 ? 0 : 1;
            ChildSender.intensifyAndUpgradeEquip(2,_composeTemp.Id,_loc4_);
            model.moveGoodsBack();
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __intensifyClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = getTimer();
         if(_loc4_ - _curEvolveTimeStamp < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _curEvolveTimeStamp = _loc4_;
         if(curSelectChild)
         {
            if(model.hideGoods == null)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellDropMediator.command01"));
               return;
            }
            if(model.hideGoods.strengthenGrade >= model.hideGoods.templateInfo.StrengthenMax)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fighting.FightingItem.desction1_4"));
               return;
            }
            if(_needPoint <= 0)
            {
               intensifyResultHandler(true,true);
            }
            else
            {
               SimpleAlertHelper.instance.data = [intensifyResultHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("child.equip.ChildUpgradeEquipView.intensifyContent",_needPoint);
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert");
            }
         }
      }
      
      private function intensifyResultHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            if(param2)
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc3_ >= _needPoint || _hasMaterialCount >= int(_intensifyArr[1]))
            {
               _loc4_ = param2 ? 0 : 1;
               ChildSender.intensifyAndUpgradeEquip(1,_intensifyArr[0],_loc4_);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function get curSelectChild() : ChildData
      {
         return ChildManager.instance.curSelectChild;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_resultImage);
         _resultImage = null;
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_jewel);
         _jewel = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_nameTxt1);
         _nameTxt1 = null;
         ObjectUtils.disposeObject(_nameTxt2);
         _nameTxt2 = null;
         ObjectUtils.disposeObject(_attBox1);
         _attBox1 = null;
         ObjectUtils.disposeObject(_attBox2);
         _attBox2 = null;
         ObjectUtils.disposeObject(_addImage1);
         _addImage1 = null;
         ObjectUtils.disposeObject(_addImage2);
         _addImage2 = null;
         ObjectUtils.disposeAllChildren(_currSprite);
         ObjectUtils.disposeAllChildren(_nextSprite);
         ObjectUtils.disposeObject(_currSprite);
         _currSprite = null;
         ObjectUtils.disposeObject(_nextSprite);
         _nextSprite = null;
         ObjectUtils.disposeObject(_bmd);
         _bmd = null;
         _attList = null;
         _attNameDic = null;
         _intensifyConfigInfo = null;
         super.dispose();
      }
   }
}

