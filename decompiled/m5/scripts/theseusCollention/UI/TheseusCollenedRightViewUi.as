package theseusCollention.UI
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollectionInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import theseusCollention.item.TheseusCollentionBagCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.MsgMan;
   
   public class TheseusCollenedRightViewUi extends Sprite
   {
      
      protected var _theseusCollection_RightBg:Bitmap;
      
      protected var _BigBg:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _theseusCollection_staricon:ScaleFrameImage;
      
      protected var _theseusCollection_staricon2:ScaleFrameImage;
      
      protected var _StarTxt1:FilterFrameText;
      
      protected var _StarTxt2:FilterFrameText;
      
      protected var _AttrName:FilterFrameText;
      
      protected var _AttrNumbef:FilterFrameText;
      
      protected var _AttrNumaft:FilterFrameText;
      
      private var lookRewardBtn:TextButton;
      
      protected var _AttrName1:FilterFrameText;
      
      protected var _AttrNumbef1:FilterFrameText;
      
      protected var _AttrNumaft1:FilterFrameText;
      
      protected var _Attrbeidong1:FilterFrameText;
      
      protected var _Attrbeidong2:FilterFrameText;
      
      protected var _quality:FilterFrameText;
      
      protected var _upStar:IconButton;
      
      protected var _jihuo:IconButton;
      
      protected var _star:MutipleImage;
      
      protected var _PassvieEffect:MutipleImage;
      
      protected var _upstarneed:MutipleImage;
      
      protected var _goldTxt:FilterFrameText;
      
      protected var _goldNum:FilterFrameText;
      
      protected var _chipTxt:FilterFrameText;
      
      protected var _chipNum:FilterFrameText;
      
      private var _goldIcon:Bitmap;
      
      private var _godIcon:Bitmap;
      
      protected var _theseusCollection_chip_pro_bg:Bitmap;
      
      protected var _jindutiao:ScaleFrameImage;
      
      protected var _preTxt:FilterFrameText;
      
      private var _url:String;
      
      private var _item:TheseusCollentionBagCell;
      
      private var _jiantou:Bitmap;
      
      private var _maskBar:Shape;
      
      private var _icon:Bitmap;
      
      private var _lookReward:Boolean = false;
      
      private var _theseusMaxCollectItemUI:TheseusMaxCollectItemUI;
      
      private var _data:TheseusCollectionInfo;
      
      private var _jindutiaoOriginWidth:Number = 0;
      
      public function TheseusCollenedRightViewUi()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         _theseusCollection_RightBg = ComponentFactory.Instance.creatBitmap("theseusCollection_RightBg");
         _BigBg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.BigBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.nameTxt");
         _theseusCollection_staricon = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_staricon");
         _theseusCollection_staricon2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_starcoloricon");
         _StarTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.StarTxt1");
         _StarTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.StarTxt2");
         _AttrName = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrName");
         _AttrNumbef = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrNumbef");
         _AttrNumaft = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrNumaft");
         _AttrName1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrName");
         _AttrNumbef1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrNumbef");
         _AttrNumaft1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.AttrNumaft");
         _Attrbeidong1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.Attrbeidong1");
         _Attrbeidong2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.Attrbeidong2");
         _quality = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.quality");
         _upStar = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.upStar");
         _jihuo = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.jihuo");
         _star = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.star");
         _PassvieEffect = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.PassvieEffect");
         _upstarneed = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.upstarneed");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.goldTxt");
         _goldNum = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.goldnum");
         _chipTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.chipTxt");
         _chipNum = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.chipnum");
         _goldIcon = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GoldIconAsset");
         addChild(_goldIcon);
         _godIcon = ComponentFactory.Instance.creatBitmap("theseusCollection_metalofGodIconSmall");
         addChild(_godIcon);
         _theseusCollection_chip_pro_bg = ComponentFactory.Instance.creatBitmap("theseusCollection_chip_pro_bg");
         _jindutiao = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.jindutiao");
         _preTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.preTxt");
         _jiantou = ComponentFactory.Instance.creatBitmap("theseusCollection_jiantou");
         addChild(_jiantou);
         _jiantou.x = 140;
         lookRewardBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.lookRewardBtn");
         _godIcon.x = 20;
         _godIcon.y = 345;
         addChild(_BigBg);
         addChild(_nameTxt);
         addChild(_theseusCollection_staricon);
         addChild(_theseusCollection_staricon2);
         addChild(_StarTxt1);
         addChild(_StarTxt2);
         addChild(_AttrName);
         addChild(_AttrNumbef);
         addChild(_AttrNumaft);
         addChild(lookRewardBtn);
         addChild(_AttrName1);
         addChild(_AttrNumbef1);
         addChild(_AttrNumaft1);
         addChild(_Attrbeidong1);
         addChild(_Attrbeidong2);
         addChild(_quality);
         addChild(_upStar);
         addChild(_jihuo);
         addChild(_star);
         addChild(_PassvieEffect);
         addChild(_upstarneed);
         addChild(_goldTxt);
         addChild(_goldNum);
         addChild(_chipTxt);
         addChild(_chipNum);
         addChild(_theseusCollection_chip_pro_bg);
         addChild(_jindutiao);
         addChild(_preTxt);
         _theseusCollection_chip_pro_bg.y = 70;
         _jindutiao.y = 77;
         _preTxt.y = 74;
         _theseusCollection_chip_pro_bg.x = 60;
         _preTxt.x = 65;
         _jindutiao.x = 85;
         _goldIcon.x = 20;
         _goldIcon.y = 320;
         this.visible = false;
         _item = ComponentFactory.Instance.creatCustomObject("theseusCollention.item.TheseusCollentionBagCell");
         _item.x = 100;
         _item.y = 380;
         addChild(_item);
         _maskBar = new Shape();
         _maskBar.x = _jindutiao.x;
         _maskBar.y = _jindutiao.y;
         addChild(_maskBar);
         _jindutiao.mask = _maskBar;
         _jindutiaoOriginWidth = _jindutiao.width;
         lookRewardBtn.text = LanguageMgr.GetTranslation("theseus.equip.QHtips2");
         lookRewardBtn.x = 180;
         lookRewardBtn.y = 128;
         _theseusMaxCollectItemUI = new TheseusMaxCollectItemUI();
         addChild(_theseusMaxCollectItemUI);
         _theseusMaxCollectItemUI.y = 150;
         _theseusMaxCollectItemUI.visible = false;
      }
      
      private function initLoad() : void
      {
         LoaderManagerII.instance.load(_url,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is Bitmap)
         {
            initView1(param2 as Bitmap);
         }
      }
      
      private function initView1(param1:Bitmap) : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _icon = param1;
         addChildAt(_icon,4);
         _icon.x = 65;
         _icon.y = 10;
         if(!_data.isPassive)
         {
            _icon.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function initEvents() : void
      {
         MsgMan.addObserver("TheseusCollentionItemUI",null,showEquipInfo);
         _jihuo.addEventListener("click",__jihuoBtnClickHandler);
         _upStar.addEventListener("click",__jihuoBtnClickHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",yiUpdateHandler);
         lookRewardBtn.addEventListener("mouseDown",__lookRewardHandler);
      }
      
      private function removeEvents() : void
      {
         MsgMan.removeObserver("TheseusCollentionItemUI",null,showEquipInfo);
         _jihuo.removeEventListener("click",__jihuoBtnClickHandler);
         _upStar.removeEventListener("click",__jihuoBtnClickHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_COLLECTION_UPDATE",yiUpdateHandler);
         if(lookRewardBtn)
         {
            lookRewardBtn.removeEventListener("mouseDown",__lookRewardHandler);
         }
      }
      
      private function __lookRewardHandler(param1:MouseEvent) : void
      {
         _lookReward = !_lookReward;
         _theseusMaxCollectItemUI.refreView(_data.starMaxInfo);
         _theseusMaxCollectItemUI.visible = _lookReward;
      }
      
      private function yiUpdateHandler(param1:Event) : void
      {
         var _loc2_:TheseusCollectionInfo = model.getSelectData(model.selectData);
         if(_loc2_)
         {
            data = _loc2_;
         }
      }
      
      public function setItemText(param1:int) : String
      {
         var _loc2_:String = null;
         if(param1 == 0)
         {
            return "0";
         }
         var _loc3_:Number = param1 / 1000;
         if(param1 % 1000 == 0)
         {
            if(_loc3_ >= 1)
            {
               _loc2_ = int(_loc3_) + "k";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = _loc3_.toFixed(1) + "k";
         }
         else if(_loc3_ > 10)
         {
            _loc2_ = int(_loc3_) + "k";
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      private function __jihuoBtnClickHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doCollectionthing(2,_data.templeteInfo.TemplateId);
      }
      
      private function __upstarCoreBtnClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function showEquipInfo(param1:String, param2:TheseusCollectionInfo) : void
      {
         data = param2;
      }
      
      public function get data() : TheseusCollectionInfo
      {
         return _data;
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      public function set data(param1:TheseusCollectionInfo) : void
      {
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:Array = null;
         var _loc10_:Array = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:GoodsInfo = null;
         _data = param1;
         _lookReward = false;
         _theseusMaxCollectItemUI.visible = false;
         if(_data)
         {
            this.visible = true;
         }
         _url = PathManager.getcollectionPicPath(_data.templeteInfo.TemplateId + "");
         initLoad();
         _jihuo.visible = false;
         var _loc12_:int = int(gold.count);
         _theseusCollection_staricon2.visible = false;
         _jindutiao.visible = false;
         _theseusCollection_chip_pro_bg.visible = false;
         _jiantou.visible = false;
         _BigBg.setFrame(_data.templeteInfo.Profile - 2);
         _nameTxt.text = _data.templeteInfo.TemplateName;
         _nameTxt.textColor = model.color[_data.templeteInfo.Profile - 3];
         _godIcon.visible = false;
         _quality.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.profile" + (_data.templeteInfo.Profile - 2));
         _quality.textColor = model.color[_data.templeteInfo.Profile - 3];
         _preTxt.text = "";
         _StarTxt2.text = "";
         _goldTxt.text = "";
         _goldNum.text = "";
         _chipTxt.text = "";
         _chipNum.text = "";
         _item.visible = false;
         _AttrName1.text = "";
         _AttrNumbef1.text = "";
         _AttrNumaft1.text = "";
         _upStar.visible = false;
         var _loc8_:String = "";
         var _loc9_:String = "";
         _StarTxt1.x = 84;
         _goldIcon.visible = false;
         var _loc4_:String = "#000000";
         _PassvieEffect.visible = _data.starInfo.SpecialeffectDesc != "";
         if(_data.starnextInfo)
         {
            _loc10_ = _data.starnextInfo.hasValueAtt;
            _theseusCollection_staricon.visible = true;
            for each(var _loc13_:GoodsInfo in model.armorBagDic)
            {
               if(_loc13_.templateInfo.TemplateId == _data.starnextInfo.chipId)
               {
                  _loc3_ = int(_loc13_.count);
               }
               if(_loc13_.templateInfo.TemplateId == _data.starnextInfo.chipId1)
               {
                  _loc11_ = int(_loc13_.count);
               }
            }
            _loc8_ = _loc10_[0] ? _loc10_[0] : "";
            _loc9_ = _loc10_[1] ? _loc10_[1] : "";
         }
         _jiantou.y = _loc9_ != "" ? 205 : 196;
         if(_data.isPassive)
         {
            _theseusCollection_staricon.visible = true;
            _upstarneed.visible = true;
            _loc10_ = _data.starInfo.hasValueAtt;
            _loc8_ = _loc10_[0] ? _loc10_[0] : "";
            _loc9_ = _loc10_[1] ? _loc10_[1] : "";
            if(_icon)
            {
               _icon.filters = null;
            }
            _theseusCollection_staricon.x = 55;
            _AttrName.y = _AttrNumbef.y = _AttrNumaft.y = 198;
            _AttrName1.y = _AttrNumbef1.y = _AttrNumaft1.y = 217;
            _AttrName.x = _AttrName1.x = 0;
            _AttrNumbef.x = _AttrNumbef1.x = 86;
            _loc2_ = _data.starInfo ? _data.starInfo.hasValueAtt : [];
            _AttrName.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc8_);
            _Attrbeidong1.text = _data.starInfo.SpecialeffectDesc;
            _AttrNumbef.text = _data.starInfo[_loc2_[0]];
            if(_loc9_ != "")
            {
               _AttrNumbef1.text = _data.starInfo[_loc2_[1]];
               _AttrName1.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc9_);
            }
            if(_data.star <= 5)
            {
               _theseusCollection_staricon.setFrame(1);
            }
            else
            {
               _theseusCollection_staricon.setFrame(2);
            }
            _StarTxt1.text = "x" + _data.star;
            if(_data.starnextInfo)
            {
               if(_loc9_ != "")
               {
                  _AttrNumaft1.text = _data.starnextInfo[_loc9_];
               }
               _AttrNumaft.text = _data.starnextInfo[_loc8_];
               _item.visible = true;
               _StarTxt2.text = "x" + (_data.star + 1);
               _theseusCollection_staricon2.visible = true;
               if(_data.star <= 4)
               {
                  _theseusCollection_staricon2.setFrame(1);
               }
               else
               {
                  _theseusCollection_staricon2.setFrame(2);
               }
               _upStar.visible = true;
               _goldIcon.visible = true;
               _jiantou.visible = true;
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _data.starnextInfo.chipId;
               _item.data = _loc7_;
               _loc4_ = _data.starnextInfo.chipNeedNum > _loc3_ ? "#CE0F0F" : "#04EF25";
               _loc8_ = "<font color=\'" + _loc4_ + "\'>" + setItemText(_loc3_) + "</font>" + "/" + setItemText(_data.starnextInfo.chipNeedNum);
               _item.setItemText1(_loc8_,true);
               _goldTxt.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.gold");
               _loc4_ = _data.starnextInfo.UpGold > _loc12_ ? "#CE0F0F" : "#04EF25";
               _loc8_ = "<font color=\'" + _loc4_ + "\'>" + setItemText(_loc12_) + "</font>" + "<font color=\'#E9C68C\'>" + "/" + setItemText(_data.starnextInfo.UpGold) + "</font>";
               _goldNum.htmlText = _loc8_;
               _upStar.enable = _data.starnextInfo.UpGold <= _loc12_;
               if(_data.starnextInfo.chipNeedNum1 > 0)
               {
                  _godIcon.visible = true;
                  _chipTxt.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.chip");
                  _loc4_ = _data.starnextInfo.chipNeedNum1 > _loc11_ ? "#CE0F0F" : "#04EF25";
                  _loc8_ = "<font color=\'" + _loc4_ + "\'>" + setItemText(_loc11_) + "</font>" + "<font color=\'#E9C68C\'>" + "/" + setItemText(_data.starnextInfo.chipNeedNum1) + "</font>";
                  _chipNum.htmlText = _loc8_;
                  _upStar.enable = _data.starnextInfo.UpGold <= _loc12_ && _loc11_ >= _data.starnextInfo.chipNeedNum1;
               }
            }
            else
            {
               _item.visible = false;
               _AttrNumaft.text = "";
               _AttrNumaft1.text = "";
               _theseusCollection_staricon.x = 90;
               _StarTxt1.x = 114;
               _AttrName.x = _AttrName1.x = 27;
               _AttrNumbef.x = _AttrNumbef1.x = 116;
               _upstarneed.visible = false;
               _AttrName.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc2_[0]);
               if(_loc9_ != "")
               {
                  _AttrName1.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc2_[1]);
               }
            }
         }
         else
         {
            _upstarneed.visible = false;
            _StarTxt1.text = "";
            _StarTxt2.text = "";
            _theseusCollection_staricon.visible = _theseusCollection_staricon2.visible = false;
            if(_data.starnextInfo.SpecialeffectDesc != "")
            {
               _Attrbeidong1.text = _data.starnextInfo.SpecialeffectDesc.split(":")[0] + ":0";
            }
            else
            {
               _Attrbeidong1.text = "";
            }
            _AttrName.y = _AttrNumbef.y = _AttrNumaft.y = 180;
            _AttrName1.y = _AttrNumbef1.y = _AttrNumaft1.y = 198;
            _AttrName.x = _AttrName1.x = 27;
            _AttrNumbef.x = _AttrNumbef1.x = 116;
            _AttrName.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc8_);
            _AttrNumbef.text = "0";
            _AttrNumaft.text = "";
            if(_loc9_ != "")
            {
               _AttrName1.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc9_);
               _AttrNumbef1.text = "0";
               _AttrNumaft1.text = "";
            }
            if(_loc3_ > 0)
            {
               _jindutiao.visible = true;
               _jindutiao.setFrame(_data.templeteInfo.Profile - 2);
               showPrecent(_loc3_,_data.starnextInfo.chipNeedNum);
               _preTxt.htmlText = setItemText(_loc3_) + "/" + _data.starnextInfo.chipNeedNum;
               _theseusCollection_chip_pro_bg.visible = true;
            }
            if(_loc3_ < _data.starnextInfo.chipNeedNum)
            {
               _jihuo.visible = false;
            }
            else
            {
               _jihuo.visible = true;
            }
         }
      }
      
      public function showPrecent(param1:Number, param2:Number) : void
      {
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc3_:Number = param1 / param2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         _maskBar.graphics.clear();
         _maskBar.graphics.beginFill(16711680);
         _maskBar.graphics.drawRect(0,0,_jindutiaoOriginWidth * _loc3_,_jindutiao.height);
         _maskBar.graphics.endFill();
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_theseusCollection_RightBg);
         _theseusCollection_RightBg = null;
         ObjectUtils.disposeObject(_BigBg);
         _BigBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_theseusCollection_staricon);
         _theseusCollection_staricon = null;
         ObjectUtils.disposeObject(_theseusCollection_staricon2);
         _theseusCollection_staricon2 = null;
         ObjectUtils.disposeObject(_StarTxt1);
         _StarTxt1 = null;
         ObjectUtils.disposeObject(_StarTxt2);
         _StarTxt2 = null;
         ObjectUtils.disposeObject(_AttrName);
         _AttrName = null;
         ObjectUtils.disposeObject(_AttrNumbef);
         _AttrNumbef = null;
         ObjectUtils.disposeObject(_AttrNumaft);
         _AttrNumaft = null;
         ObjectUtils.disposeObject(_AttrName1);
         _AttrName1 = null;
         ObjectUtils.disposeObject(_AttrNumbef1);
         _AttrNumbef1 = null;
         ObjectUtils.disposeObject(_AttrNumaft1);
         _AttrNumaft1 = null;
         ObjectUtils.disposeObject(_Attrbeidong1);
         _Attrbeidong1 = null;
         ObjectUtils.disposeObject(_Attrbeidong2);
         _Attrbeidong2 = null;
         ObjectUtils.disposeObject(_quality);
         _quality = null;
         ObjectUtils.disposeObject(_upStar);
         _upStar = null;
         ObjectUtils.disposeObject(_jihuo);
         _jihuo = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         ObjectUtils.disposeObject(_PassvieEffect);
         _PassvieEffect = null;
         ObjectUtils.disposeObject(_upstarneed);
         _upstarneed = null;
         ObjectUtils.disposeObject(_maskBar);
         _maskBar = null;
         ObjectUtils.disposeObject(_jiantou);
         _jiantou = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_goldNum);
         _goldNum = null;
         ObjectUtils.disposeObject(_chipTxt);
         _chipTxt = null;
         ObjectUtils.disposeObject(_chipNum);
         _chipNum = null;
         ObjectUtils.disposeObject(lookRewardBtn);
         lookRewardBtn = null;
         ObjectUtils.disposeObject(_theseusCollection_chip_pro_bg);
         _theseusCollection_chip_pro_bg = null;
         ObjectUtils.disposeObject(_jindutiao);
         _jindutiao = null;
         ObjectUtils.disposeObject(_preTxt);
         _preTxt = null;
         ObjectUtils.disposeObject(_godIcon);
         _godIcon = null;
         ObjectUtils.disposeObject(_goldIcon);
         _goldIcon = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

