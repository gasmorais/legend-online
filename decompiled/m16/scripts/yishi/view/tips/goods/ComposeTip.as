package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class ComposeTip extends EquipTip
   {
      
      private var _box1:VBox;
      
      private var _title:FilterFrameText;
      
      private var _needGrade:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _sendTxt:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _studyTxt:FilterFrameText;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _container:Sprite;
      
      private var _splitLine:Bitmap;
      
      private var _bandSprite:Sprite;
      
      public function ComposeTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _container = new Sprite();
         _bandSprite = new Sprite();
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _box1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText");
         _sendTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _title.x = 81;
         _title.y = 20;
         _title.height = 40;
         _needGrade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText_2");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.ComposeDescribeText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("tips.ComposeNeedTxt");
         _needTxt.width = 330;
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText2");
         _studyTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodStudyText");
         addChild(_totalBox);
         _totalBox.x = _totalBox.y = 10;
         _totalBox.spacing = 6;
         _box1.spacing = 0;
         _container.addChild(_itemIcon);
         _container.addChild(_profileImg);
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
         _needGrade.x = 100;
         _studyTxt.text = _loc1_;
         _studyTxt.x = 165;
         _describe.width = 330;
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:GoodsInfo = null;
         var _loc9_:PlayerInfo = null;
         var _loc1_:String = null;
         var _loc7_:ComposeGoodsTemplete = null;
         var _loc2_:GoodsInfo = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:String = null;
         if(tipData)
         {
            clean();
            _loc8_ = tipData as GoodsInfo;
            _title.text = _loc8_.templateInfo.TemplateName;
            _title.setFrame(_loc8_.templateInfo.Profile);
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc8_.templateInfo.TemplateId);
            _profileImg.setFrame(_loc8_.templateInfo.Profile);
            _needGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade02",_loc8_.templateInfo.NeedGrades);
            _describe.text = _loc8_.templateInfo.Description;
            _describe.height = _describe.textHeight + _describe.numLines * 2;
            if(_describe.height < 18)
            {
               _describe.height = 18;
            }
            if(_loc8_.isBinds)
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               _bindText.setFrame(1);
            }
            else
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               _bindText.setFrame(2);
            }
            _container.addChild(_title);
            _bandSprite.addChild(_bindText);
            _bindText.x = 0;
            _bindText.y = 0;
            _box1.addChild(_container);
            _loc9_ = PlayerManager.instance.currentPlayerModel.playerInfo;
            if(_loc9_.composeList.indexOf(_loc8_.templateInfo.Property1) >= 0)
            {
               _box1.addChild(_studyTxt);
            }
            if(_loc8_.templateInfo.SonType == 211)
            {
               _bandSprite.addChild(_needGrade);
            }
            _box1.addChild(_bandSprite);
            _box1.addChild(_describe);
            _totalBox.addChild(_box1);
            _loc1_ = "";
            _loc7_ = TempleteManager.instance.getComposeTempleteById(_loc8_.templateInfo.Property1);
            if(_loc7_)
            {
               _loc2_ = new GoodsInfo();
               _loc2_.templateId = _loc7_.NewMaterial;
               if(_loc2_.templateInfo.MasterType == 1)
               {
                  _equipTipsContent.spacing = 0;
                  _equipTipsContent.data = _loc2_;
                  _totalBox.addChild(_equipTipsContent);
               }
               _loc4_ = false;
               _loc3_ = 1;
               while(_loc3_ < 5)
               {
                  if(_loc7_["Material" + _loc3_] > 0)
                  {
                     if(!_loc4_)
                     {
                        _totalBox.addChild(_splitLine);
                        _splitLine.width = 210;
                     }
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_["Material" + _loc3_]);
                     _loc1_ += _loc6_.TemplateName + "*" + _loc7_["Count" + _loc3_];
                     _loc4_ = true;
                  }
                  _loc3_++;
               }
            }
            _needTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ComposeTip.need") + _loc1_;
            _needTxt.height = _needTxt.textHeight + _needTxt.numLines * 4;
            if(!StringHelper.isNullOrEmpty(_loc1_))
            {
               _totalBox.addChild(_needTxt);
            }
            if(_loc8_.validDate > 0)
            {
               _totalBox.addChild(_timeText);
            }
            if(_loc8_.leftTime == -1)
            {
               _loc5_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
            }
            else if(_loc8_.leftTime < 0)
            {
               _loc5_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            }
            else
            {
               _loc5_ = DateFormatter.getFullDateString(_loc8_.leftTime);
            }
            _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc5_;
            _price.text = _loc8_.templateInfo.SellGold == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",_loc8_.templateInfo.SellGold);
            _sendTxt.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
            if(_loc8_.id != 0)
            {
               _totalBox.addChild(_sendTxt);
               _totalBox.addChild(_price);
               _bandSprite.addChild(_bindText);
               _bindText.visible = true;
            }
            else
            {
               if(_sendTxt.parent)
               {
                  _sendTxt.parent.removeChild(_sendTxt);
               }
               _bindText.visible = false;
            }
            _price.x = 68;
            _bg.height = -_bg.y + _totalBox.y + _totalBox.height + 20;
            _yellowBg.height = _bg.height - 9;
            _yellowBg.width = _bg.width;
            _purpleBg.height = _bg.height - 9;
            _purpleBg.width = _bg.width;
            _blueBg.height = _bg.height - 9;
            _blueBg.width = _bg.width;
            _greenBg.height = _bg.height - 9;
            _greenBg.width = _bg.width;
            _whiteBg.height = _bg.height - 9;
            _whiteBg.width = _bg.width;
            showProfileBg(_loc8_.templateInfo.Profile);
         }
      }
      
      override protected function clean() : void
      {
         _totalBox.removeAllChild();
         _box1.removeAllChild();
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         _redBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               _whiteBg.y = _bg.y + 9;
               break;
            case 1:
               _greenBg.visible = true;
               _greenBg.y = _bg.y - 9;
               break;
            case 2:
               _blueBg.visible = true;
               _blueBg.y = _bg.y + 9;
               break;
            case 3:
               _purpleBg.visible = true;
               _purpleBg.y = _bg.y + 9;
               break;
            case 4:
               _yellowBg.visible = true;
               _yellowBg.y = _bg.y + 9;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_container);
         if(_bandSprite)
         {
            ObjectUtils.disposeObject(_bandSprite);
         }
         _bandSprite = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_splitLine)
         {
            ObjectUtils.disposeObject(_splitLine);
         }
         _splitLine = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_timeText)
         {
            _timeText.dispose();
         }
         _timeText = null;
         if(_box1)
         {
            _box1.dispose();
         }
         _box1 = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_needGrade)
         {
            _needGrade.dispose();
         }
         _needGrade = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_needTxt)
         {
            _needTxt.dispose();
         }
         _needTxt = null;
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_studyTxt)
         {
            _studyTxt.dispose();
         }
         _studyTxt = null;
         if(_sendTxt)
         {
            ObjectUtils.disposeObject(_sendTxt);
         }
         _sendTxt = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

