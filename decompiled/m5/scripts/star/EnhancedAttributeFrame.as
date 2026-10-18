package star
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.star.StarTroughInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.StarManager;
   import yishi.manager.TempleteManager;
   
   public class EnhancedAttributeFrame extends Frame
   {
      
      private var _data:StarTroughInfo;
      
      private var _bg1:Bitmap;
      
      private var _bg2:Scale9CornerImage;
      
      private var _effect01:ScaleFrameImage;
      
      private var _effect02:ScaleFrameImage;
      
      private var _effectBg:MutipleImage;
      
      private var _starEffectAdd1:Bitmap;
      
      private var _starEffectAdd2:Bitmap;
      
      private var _starEffectMax:Bitmap;
      
      private var _currLevel:FilterFrameText;
      
      private var _nextLevel:FilterFrameText;
      
      private var _blessingImg:Bitmap;
      
      private var _costGold:Bitmap;
      
      private var _costGoldTxt:FilterFrameText;
      
      private var _addAttributeBtn:IconButton;
      
      private var _addManyAttributeBtn:IconButton;
      
      private var _expBg:Bitmap;
      
      private var _expProgess:Bitmap;
      
      private var _maskSprite:Sprite;
      
      private var _splitLine:Bitmap;
      
      private var _progessTxt:FilterFrameText;
      
      public function EnhancedAttributeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("star.EnhancedAttributeFrame.titleText");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.star.addAttributeBg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("star.addAttributeBg01");
         _effectBg = ComponentFactory.Instance.creatComponentByStylename("star.starEffectaddBg");
         _starEffectAdd1 = ComponentFactory.Instance.creatBitmap("asset.star.starEffectImg");
         _starEffectAdd2 = ComponentFactory.Instance.creatBitmap("asset.star.starEffectImg");
         _starEffectMax = ComponentFactory.Instance.creatBitmap("asset.star.starEffectMax");
         _effect01 = ComponentFactory.Instance.creatComponentByStylename("star.addAttributeEffect01");
         _effect02 = ComponentFactory.Instance.creatComponentByStylename("star.addAttributeEffect02");
         _currLevel = ComponentFactory.Instance.creatComponentByStylename("star.currLevelTxt");
         _nextLevel = ComponentFactory.Instance.creatComponentByStylename("star.nextLevelTxt");
         _blessingImg = ComponentFactory.Instance.creatBitmap("asset.star.starBlessing");
         _costGold = ComponentFactory.Instance.creatBitmap("asset.star.costGold");
         _costGoldTxt = ComponentFactory.Instance.creatComponentByStylename("star.costGoldTxt");
         _addAttributeBtn = ComponentFactory.Instance.creatComponentByStylename("star.EnhancedAttributeBtn");
         _addManyAttributeBtn = ComponentFactory.Instance.creatComponentByStylename("star.oneKeyEnhancedAttributeBtn");
         _expBg = ComponentFactory.Instance.creatBitmap("asset.star.expBg");
         _expProgess = ComponentFactory.Instance.creatBitmap("asset.star.expProgress");
         _maskSprite = new Sprite();
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.star.expSplitLine");
         _progessTxt = ComponentFactory.Instance.creatComponentByStylename("star.expProgessTxt");
         addToContent(_bg2);
         addToContent(_bg1);
         addToContent(_effectBg);
         addToContent(_starEffectAdd1);
         _starEffectAdd1.x = 34;
         addToContent(_starEffectAdd2);
         _starEffectAdd2.x = 264;
         addToContent(_starEffectMax);
         addToContent(_effect01);
         _effect01.setFrame(1);
         addToContent(_effect02);
         _effect02.setFrame(10);
         addToContent(_currLevel);
         _currLevel.text = LanguageMgr.GetTranslation("public.level2",9);
         addToContent(_nextLevel);
         _nextLevel.text = LanguageMgr.GetTranslation("public.level2",10);
         addToContent(_blessingImg);
         addToContent(_costGold);
         addToContent(_costGoldTxt);
         _costGoldTxt.text = "1000000";
         addToContent(_addAttributeBtn);
         addToContent(_addManyAttributeBtn);
         addToContent(_expBg);
         addToContent(_expProgess);
         addToContent(_maskSprite);
         addToContent(_splitLine);
         addToContent(_progessTxt);
         _progessTxt.text = "100/100";
         setMaskSprite(50,100);
         _expProgess.mask = _maskSprite;
         _addAttributeBtn.tipData = LanguageMgr.GetTranslation("star.EnhancedAttributeFrame.normalBtnTip");
         _addManyAttributeBtn.tipData = LanguageMgr.GetTranslation("star.EnhancedAttributeFrame.quickBtnTip");
      }
      
      private function setMaskSprite(param1:int, param2:int) : void
      {
         var _loc3_:int = _expProgess.width * param1 / param2;
         _maskSprite.graphics.clear();
         _maskSprite.graphics.beginFill(0,0);
         _maskSprite.graphics.drawRect(_expProgess.x,_expProgess.y,_loc3_,_expProgess.height);
         _maskSprite.graphics.endFill();
      }
      
      public function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         NotificationManager.instance.addEventListener("REFRESH_STARTROUGHINFO",refreshView);
         _addAttributeBtn.addEventListener("click",__addAttributeBtnHandler);
         _addManyAttributeBtn.addEventListener("click",__addManyAttributeBtnHandler);
      }
      
      private function refreshView(param1:NotificationEvent) : void
      {
         var _loc3_:StarTroughInfo = StarManager.instance.getStarTroughInfoByPos(_data.pos);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grade + 1,103);
         _currLevel.text = LanguageMgr.GetTranslation("public.level2",_loc3_.grade);
         _effect01.setFrame(_loc3_.grade + 1);
         if(_loc3_.grade >= 10)
         {
            _addAttributeBtn.enable = false;
            _addManyAttributeBtn.enable = false;
            _nextLevel.visible = false;
            _effect02.visible = false;
            _starEffectAdd2.visible = false;
            _starEffectMax.visible = true;
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grade,103);
            _progessTxt.text = _loc2_.Data + " / " + _loc2_.Data;
            setMaskSprite(_loc2_.Data,_loc2_.Data);
         }
         else
         {
            _nextLevel.text = LanguageMgr.GetTranslation("public.level2",_loc3_.grade + 1);
            _addAttributeBtn.enable = true;
            _addManyAttributeBtn.enable = true;
            _starEffectMax.visible = false;
            _progessTxt.text = _loc3_.gp + " / " + _loc2_.Data;
            _effect02.setFrame(_loc3_.grade + 2);
            setMaskSprite(_loc3_.gp,_loc2_.Data);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         NotificationManager.instance.removeEventListener("REFRESH_STARTROUGHINFO",refreshView);
         _addAttributeBtn.removeEventListener("click",__addAttributeBtnHandler);
         _addManyAttributeBtn.removeEventListener("click",__addManyAttributeBtnHandler);
      }
      
      private function __addAttributeBtnHandler(param1:MouseEvent) : void
      {
         _addAttributeBtn.enable = false;
         StarManager.instance.sendStarAddition(_data.pos,1);
      }
      
      private function __addManyAttributeBtnHandler(param1:MouseEvent) : void
      {
         _addManyAttributeBtn.enable = false;
         StarManager.instance.sendStarAddition(_data.pos,10);
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
         }
      }
      
      public function show(param1:*) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         _data = param1;
         refreshView(null);
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FrameControllerManager.instance.starController._info = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1;
         ObjectUtils.disposeObject(_bg2);
         _bg2;
         ObjectUtils.disposeObject(_effect01);
         _effect01 = null;
         ObjectUtils.disposeObject(_effect02);
         _effect02 = null;
         ObjectUtils.disposeObject(_effectBg);
         _effectBg = null;
         ObjectUtils.disposeObject(_starEffectAdd1);
         _starEffectAdd1 = null;
         ObjectUtils.disposeObject(_starEffectAdd2);
         _starEffectAdd2 = null;
         ObjectUtils.disposeObject(_currLevel);
         _currLevel = null;
         ObjectUtils.disposeObject(_nextLevel);
         _nextLevel = null;
         ObjectUtils.disposeObject(_blessingImg);
         _blessingImg = null;
         ObjectUtils.disposeObject(_costGold);
         _costGold = null;
         ObjectUtils.disposeObject(_costGoldTxt);
         _costGoldTxt = null;
         ObjectUtils.disposeObject(_addAttributeBtn);
         _addAttributeBtn = null;
         ObjectUtils.disposeObject(_expBg);
         _expBg = null;
         ObjectUtils.disposeObject(_expProgess);
         _expProgess = null;
         _maskSprite.graphics.clear();
         ObjectUtils.disposeObject(_maskSprite);
         _maskSprite = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

