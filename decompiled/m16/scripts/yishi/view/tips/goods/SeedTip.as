package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class SeedTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _sendTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _matureTimeTxt:FilterFrameText;
      
      private var _outputTxt:FilterFrameText;
      
      private var _raisedCeilingTxt:FilterFrameText;
      
      private var _dscTxt:FilterFrameText;
      
      private var _specialTxt:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _bindTxt:FilterFrameText;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      public function SeedTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 300;
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _bindTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText2");
         _specialTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTypeTxt");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _matureTimeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _outputTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _raisedCeilingTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _dscTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.width = 210;
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02.width = 210;
         _sendTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _nameTxt.x = 76;
         _nameTxt.y = 15;
         _nameTxt.width = 220;
         _specialTxt.width = 58;
         _specialTxt.x = 0;
         _specialTxt.y = 1;
         _bindTxt.x = 0;
         _bindTxt.y = 0;
         _matureTimeTxt.width = 170;
         _outputTxt.width = 170;
         _totalBox.x = 10;
         _totalBox.spacing = 4;
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         addChild(_nameTxt);
         addChild(_totalBox);
         _totalBox.y = 55;
         _priceTxt.x = 70;
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc1_:String = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc4_:String = null;
         if(tipData)
         {
            clean();
            _loc5_ = tipData as GoodsInfo;
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId);
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc5_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc5_.templateInfo.Profile);
            if(_loc3_)
            {
               _totalBox.addChild(_specialTxt);
               _totalBox.addChild(_bindTxt);
               _totalBox.addChild(_splitLine01);
               _totalBox.addChild(_matureTimeTxt);
               _totalBox.addChild(_outputTxt);
               _totalBox.addChild(_raisedCeilingTxt);
               _totalBox.addChild(_dscTxt);
               _totalBox.addChild(_splitLine02);
               _totalBox.addChild(_sendTxt);
               _totalBox.addChild(_priceTxt);
               _loc1_ = "";
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.Property2);
               _nameTxt.text = _loc3_.TemplateName;
               _nameTxt.setFrame(_loc3_.Profile);
               if(int(_loc3_.Property1 / 60) <= 0)
               {
                  _loc1_ = LanguageMgr.GetTranslation("public.needMinutes",_loc3_.Property1 % 60);
               }
               else if(_loc3_.Property1 % 60 == 0)
               {
                  _loc1_ = int(_loc3_.Property1 / 60) + LanguageMgr.GetTranslation("public.time.hour");
               }
               else
               {
                  _loc1_ = LanguageMgr.GetTranslation("public.needHM",int(_loc3_.Property1 / 60),_loc3_.Property1 % 60);
               }
               _matureTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.matureTime",_loc1_);
               if(_loc2_)
               {
                  _loc1_ = _loc3_.Property3 + _loc2_.TemplateName;
               }
               else
               {
                  _loc1_ = _loc3_.Property3.toString();
               }
               _outputTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.output",_loc1_);
               if(_loc5_.templateInfo.SonType == 1500)
               {
                  _raisedCeilingTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.raisedCeilingTxt",_loc5_.templateInfo.Property5.toString());
               }
               else if(_totalBox.contains(_raisedCeilingTxt))
               {
                  _totalBox.removeChild(_raisedCeilingTxt);
               }
               _dscTxt.text = _loc3_.Description;
               _dscTxt.height = _dscTxt.textHeight + 5;
               if(_loc3_.Property5 > 0)
               {
                  _specialTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SeedTip.specialCrop");
               }
               else if(_specialTxt.parent)
               {
                  _specialTxt.parent.removeChild(_specialTxt);
               }
               if(_loc5_.validDate > 0)
               {
                  _totalBox.addChild(_timeText);
               }
               if(_loc5_.leftTime == -1)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc5_.leftTime < 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc4_ = DateFormatter.getFullDateString(_loc5_.leftTime);
               }
               _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc4_;
               if(_loc5_.id != 0)
               {
                  if(_loc5_.isBinds)
                  {
                     _bindTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
                     _bindTxt.setFrame(1);
                  }
                  else
                  {
                     _bindTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
                     _bindTxt.setFrame(2);
                  }
                  _priceTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",_loc3_.SellGold);
                  _sendTxt.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
               }
               else
               {
                  if(_splitLine01.parent)
                  {
                     _splitLine01.parent.removeChild(_splitLine01);
                  }
                  if(_priceTxt.parent)
                  {
                     _priceTxt.parent.removeChild(_priceTxt);
                  }
                  if(_bindTxt.parent)
                  {
                     _bindTxt.parent.removeChild(_bindTxt);
                  }
                  if(_splitLine02.parent)
                  {
                     _splitLine02.parent.removeChild(_splitLine02);
                  }
                  if(_sendTxt.parent)
                  {
                     _sendTxt.parent.removeChild(_sendTxt);
                  }
               }
            }
            _totalBox.refreshChildPos();
            _bg.height = _totalBox.y + _totalBox.height + 10;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _yellowBg.width = _bg.width;
            _purpleBg.width = _bg.width;
            _blueBg.width = _bg.width;
            _greenBg.width = _bg.width;
            _whiteBg.width = _bg.width;
            _yellowBg.y = _bg.y - 3;
            _purpleBg.y = _bg.y - 3;
            _blueBg.y = _bg.y - 3;
            _greenBg.y = _bg.y - 3;
            _whiteBg.y = _bg.y - 3;
            showProfileBg(_loc5_.templateInfo.Profile);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
         }
      }
      
      private function clean() : void
      {
         while(_totalBox.numChildren > 0)
         {
            _totalBox.removeChildAt(_totalBox.numChildren - 1);
         }
      }
      
      override public function dispose() : void
      {
         if(_yellowBg)
         {
            ObjectUtils.disposeObject(_yellowBg);
         }
         _yellowBg = null;
         if(_purpleBg)
         {
            ObjectUtils.disposeObject(_purpleBg);
         }
         _purpleBg = null;
         if(_blueBg)
         {
            ObjectUtils.disposeObject(_blueBg);
         }
         _blueBg = null;
         if(_greenBg)
         {
            ObjectUtils.disposeObject(_greenBg);
         }
         _greenBg = null;
         if(_whiteBg)
         {
            ObjectUtils.disposeObject(_whiteBg);
         }
         _whiteBg = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_timeText)
         {
            _timeText.dispose();
         }
         _timeText = null;
         if(_splitLine01)
         {
            ObjectUtils.disposeObject(_splitLine01);
         }
         _splitLine01 = null;
         if(_splitLine02)
         {
            ObjectUtils.disposeObject(_splitLine02);
         }
         _splitLine02 = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_matureTimeTxt)
         {
            _matureTimeTxt.dispose();
         }
         _matureTimeTxt = null;
         if(_outputTxt)
         {
            _outputTxt.dispose();
         }
         _outputTxt = null;
         if(_specialTxt)
         {
            _specialTxt.dispose();
         }
         _specialTxt = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_priceTxt)
         {
            _priceTxt.dispose();
         }
         _priceTxt = null;
         if(_bindTxt)
         {
            _bindTxt.dispose();
         }
         _bindTxt = null;
         if(_sendTxt)
         {
            ObjectUtils.disposeObject(_sendTxt);
         }
         _sendTxt = null;
         if(_dscTxt)
         {
            ObjectUtils.disposeObject(_dscTxt);
         }
         _dscTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

