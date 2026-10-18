package child.equip
{
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
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildIntensifyEquipView extends Component
   {
      
      private static var _intensifyMaterialItem:ConfigInfosTempInfo = null;
      
      private var _equipBag:ChildEquipBagView;
      
      private var _bg:MutipleImage;
      
      private var _effectBack:MovieImage;
      
      private var _resultImage:ScaleFrameImage;
      
      private var _item:ChildBagCell;
      
      private var _jewel:BaseItemView;
      
      private var _countTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _nameTxt1:FilterFrameText;
      
      private var _nameTxt2:FilterFrameText;
      
      private var _addImage1:Image;
      
      private var _addImage2:Image;
      
      private var _currSprite:Sprite;
      
      private var _nextSprite:Sprite;
      
      private var _bmd:BitmapData;
      
      private var _attBox1:VBox;
      
      private var _attBox2:VBox;
      
      private var _attList:Array;
      
      private var _attNameDic:Dictionary;
      
      public function ChildIntensifyEquipView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      public static function getIntensifyMaterialId(param1:int) : int
      {
         if(!_intensifyMaterialItem)
         {
            _intensifyMaterialItem = TempleteManager.instance.getConfigInfoByConfigName("MaterialAndCount");
         }
         return int(_intensifyMaterialItem.ConfigValue.split("|")[param1 - 1].split(",")[0]);
      }
      
      public static function getIntensifyMaterialNeedNumber(param1:int) : int
      {
         if(!_intensifyMaterialItem)
         {
            _intensifyMaterialItem = TempleteManager.instance.getConfigInfoByConfigName("MaterialAndCount");
         }
         return int(_intensifyMaterialItem.ConfigValue.split("|")[param1 - 1].split(",")[1]);
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
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.bg");
         _resultImage = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.resultImage");
         _item = ComponentFactory.Instance.creatCustomObject("ChildIntensifyEquipView.item",[true]);
         _jewel = ComponentFactory.Instance.creatCustomObject("ChildIntensifyEquipView.jewel");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.countTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.btn");
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.nameTxt1");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.nameTxt2");
         _addImage1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.addImage1");
         _addImage2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.addImage2");
         _attBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.attBox1");
         _attBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.attBox2");
         _bmd = ComponentFactory.Instance.creatBitmapData("asset.child.intensifyAddRes");
         _equipBag = new ChildEquipBagView(2,11);
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.EquipSelectedEff");
         _effectBack.mouseChildren = _effectBack.mouseEnabled = false;
         _effectBack.movie.stop();
         _effectBack.visible = false;
         _currSprite = new Sprite();
         _nextSprite = new Sprite();
         addChild(_bg);
         addChild(_resultImage);
         addChild(_item);
         addChild(_effectBack);
         addChild(_jewel);
         addChild(_countTxt);
         addChild(_btn);
         addChild(_equipBag);
         addChild(_nameTxt1);
         addChild(_nameTxt2);
         addChild(_addImage1);
         addChild(_addImage2);
         addChild(_attBox1);
         addChild(_attBox2);
         addChild(_currSprite);
         _currSprite.x = 198;
         _currSprite.y = 108;
         addChild(_nextSprite);
         _nextSprite.x = 497;
         _nextSprite.y = 107;
         _equipBag.x = 6;
         _equipBag.y = 306;
         _item.bagType = 29;
         _item.celltType = "CELL_HIDE";
         refreshView();
      }
      
      private function initEvent() : void
      {
         if(_btn)
         {
            _btn.addEventListener("click",__clickHandler);
         }
         MsgMan.addObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.addObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.addObserver("ChildEvent.END_DROP",this,__endDropHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
         MsgMan.removeObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.removeObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.removeObserver("ChildEvent.END_DROP",this,__endDropHandler);
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
      
      private function __bagItemUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:ChildEquipAttItem = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc2_:int = 0;
         clean();
         if(model.hideGoods)
         {
            if(model.hideGoods.strengthenGrade > 0)
            {
               _addImage1.visible = true;
               _currSprite.visible = true;
               NumberViewUtils.refreshValue(model.hideGoods.strengthenGrade,_currSprite,_bmd,19,22,12,19,"0123456789");
            }
            _loc4_ = 0;
            while(_loc4_ < _attList.length)
            {
               if(model.hideGoods.templateInfo[_attList[_loc4_]] && model.hideGoods.templateInfo[_attList[_loc4_]] > 0)
               {
                  _loc3_ = int(model.hideGoods.templateInfo[_attList[_loc4_]]);
                  _loc3_ += GoodsHelp.getChildEquipStrengAddition(_loc3_,model.hideGoods.strengthenGrade);
                  _loc1_ = new ChildEquipAttItem(false);
                  _loc1_.text = _attNameDic[_attList[_loc4_]] + "+" + _loc3_;
                  _attBox1.addChild(_loc1_);
               }
               _loc4_++;
            }
            if(model.hideGoods.strengthenGrade < model.hideGoods.templateInfo.StrengthenMax)
            {
               _addImage2.visible = true;
               _nextSprite.visible = true;
               _resultImage.setFrame(1);
               _resultImage.width = 222;
               _resultImage.height = 89;
               _nameTxt2.text = model.hideGoods.templateInfo.TemplateName;
               NumberViewUtils.refreshValue(model.hideGoods.strengthenGrade + 1,_nextSprite,_bmd,19,22,12,19,"0123456789");
               _loc4_ = 0;
               while(_loc4_ < _attList.length)
               {
                  if(model.hideGoods.templateInfo[_attList[_loc4_]] && model.hideGoods.templateInfo[_attList[_loc4_]] > 0)
                  {
                     _loc3_ = int(model.hideGoods.templateInfo[_attList[_loc4_]]);
                     _loc3_ += GoodsHelp.getChildEquipStrengAddition(_loc3_,model.hideGoods.strengthenGrade + 1);
                     _loc1_ = new ChildEquipAttItem(false);
                     _loc1_.upTip = true;
                     _loc1_.text = _attNameDic[_attList[_loc4_]] + "+" + _loc3_;
                     _loc3_ = int(model.hideGoods.templateInfo[_attList[_loc4_]]);
                     _loc3_ = GoodsHelp.getChildEquipStrengAddition(_loc3_,model.hideGoods.strengthenGrade + 1) - GoodsHelp.getChildEquipStrengAddition(_loc3_,model.hideGoods.strengthenGrade);
                     _loc1_.addTxt = "+" + _loc3_;
                     _attBox2.addChild(_loc1_);
                  }
                  _loc4_++;
               }
            }
            else
            {
               _resultImage.setFrame(2);
               _resultImage.width = 144;
               _resultImage.height = 44;
            }
            if(model.hideGoods.templateInfo.Profile >= 1 && model.hideGoods.templateInfo.Profile <= 5)
            {
               _nameTxt1.setFrame(model.hideGoods.templateInfo.Profile);
               _nameTxt2.setFrame(model.hideGoods.templateInfo.Profile);
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = getIntensifyMaterialId(model.hideGoods.templateInfo.Profile);
               _jewel.data = _loc5_;
               _loc2_ = getIntensifyMaterialNeedNumber(model.hideGoods.templateInfo.Profile);
               _countTxt.text = GoodsManager.instance.getBagCountByTempId(1,_loc5_.templateId) + "/" + _loc2_;
            }
            else
            {
               _nameTxt1.setFrame(1);
               _nameTxt2.setFrame(1);
            }
            _nameTxt1.text = model.hideGoods.templateInfo.TemplateName;
            _item.data = model.hideGoods;
            _btn.enable = true;
         }
      }
      
      private function clean() : void
      {
         _attBox1.removeAllChild();
         _attBox2.removeAllChild();
         _nameTxt1.text = _nameTxt2.text = "";
         _countTxt.text = "";
         _item.data = null;
         _jewel.data = null;
         _btn.enable = false;
         _addImage1.visible = false;
         _addImage2.visible = false;
         _currSprite.visible = false;
         _nextSprite.visible = false;
         _resultImage.setFrame(1);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(ChildManager.instance.curSelectChild)
         {
            if(model.hideGoods == null)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellDropMediator.command01"));
            }
            else if(model.hideGoods.strengthenGrade >= model.hideGoods.templateInfo.StrengthenMax)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fighting.FightingItem.desction1_4"));
            }
            else
            {
               _loc2_ = getIntensifyMaterialNeedNumber(model.hideGoods.templateInfo.Profile);
               if(GoodsManager.instance.getBagCountByTempId(1,getIntensifyMaterialId(model.hideGoods.templateInfo.Profile)) < _loc2_)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("pet.equipstore.PetEquipStrengView.cannotSendPrompt02"));
               }
            }
         }
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
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_resultImage);
         _resultImage = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_jewel);
         _jewel = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_nameTxt1);
         _nameTxt1 = null;
         ObjectUtils.disposeObject(_nameTxt2);
         _nameTxt2 = null;
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
         ObjectUtils.disposeObject(_attBox1);
         _attBox1 = null;
         ObjectUtils.disposeObject(_attBox2);
         _attBox2 = null;
         _attList = null;
         _attNameDic = null;
         super.dispose();
      }
   }
}

