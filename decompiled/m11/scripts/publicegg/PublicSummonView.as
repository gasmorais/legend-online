package publicegg
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import funny.FunnyEvent;
   import funny.FunnyHelper;
   import funny.datas.FunnyData;
   import funny.view.FunnyBagItem;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class PublicSummonView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _person:Bitmap;
      
      private var _title:GradientText;
      
      private var _conditionImage:Bitmap;
      
      private var _processImage:Bitmap;
      
      private var _condition:FilterFrameText;
      
      private var _process:FilterFrameText;
      
      private var _preBack:Bitmap;
      
      private var _previewImage:Bitmap;
      
      private var _totalVBox:VBox;
      
      private var _itemVBox:VBox;
      
      private var _conditionSprite:Sprite;
      
      private var _processSprite:Sprite;
      
      private var _preSprite:Sprite;
      
      private var _txt:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      public function PublicSummonView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.publicsummon.bg");
         _person = ComponentFactory.Instance.creatBitmap("asset.publicsummon.person");
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.title");
         _conditionImage = ComponentFactory.Instance.creatBitmap("asset.funny.conditionImage");
         _processImage = ComponentFactory.Instance.creatBitmap("asset.funny.processImage");
         _condition = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.condition");
         _process = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.process");
         _preBack = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitleBack");
         _previewImage = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitle");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.itemVBox");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.totalVBox");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("publicegg.remainTimeText");
         _conditionSprite = new Sprite();
         _conditionSprite.addChild(_conditionImage);
         _conditionSprite.addChild(_condition);
         _processSprite = new Sprite();
         _processSprite.addChild(_processImage);
         _processSprite.addChild(_process);
         _preSprite = new Sprite();
         _txt = new FilterFrameText();
         _preSprite.addChild(_txt);
         _preSprite.addChild(_preBack);
         _preSprite.addChild(_previewImage);
         _totalVBox.spacing = 16;
         _title.x = 404;
         _title.y = 33;
         _totalVBox.x = 226;
         _totalVBox.y = 90;
         _totalVBox.addChild(_conditionSprite);
         _conditionSprite.x = 5;
         _totalVBox.addChild(_processSprite);
         _processSprite.x = 5;
         _totalVBox.addChild(_preSprite);
         _totalVBox.addChild(_itemVBox);
         addChild(_bg);
         addChild(_person);
         addChild(_title);
         addChild(_totalVBox);
         addChild(_remainTimeText);
         _title.text = LanguageMgr.GetTranslation("funny.view.FunnyBagView.title");
         refreshView();
      }
      
      private function initEvent() : void
      {
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler);
      }
      
      private function removeEvent() : void
      {
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler);
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FunnyBagItem = null;
         _itemVBox.disposeAllChildren();
         var _loc3_:FunnyData = FunnyManager.instance.model.eggSummonData;
         if(!_loc3_)
         {
            return;
         }
         FunnyManager.instance.selectedId = _loc3_.id;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.bagList.length)
         {
            _loc2_ = new FunnyBagItem();
            _loc2_.data = _loc3_.bagList[_loc1_];
            _itemVBox.addChild(_loc2_);
            _loc1_++;
         }
         _totalVBox.refreshChildPos();
         _condition.htmlText = _loc3_.condition;
         _process.text = FunnyHelper.processText(_loc3_);
         setRemainTime(_loc3_);
      }
      
      private function setRemainTime(param1:FunnyData) : void
      {
         var _loc2_:FunnyData = param1;
         var _loc3_:Number = _loc2_.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc3_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc3_));
         }
         else if(_loc3_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc3_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_loc2_.startTime > playerModel.nowDate)
         {
            _remainTimeText.visible = false;
         }
         else
         {
            _remainTimeText.visible = true;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_person);
         _person = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_conditionImage);
         _conditionImage = null;
         ObjectUtils.disposeObject(_processImage);
         _processImage = null;
         ObjectUtils.disposeObject(_condition);
         _condition = null;
         ObjectUtils.disposeObject(_process);
         _process = null;
         ObjectUtils.disposeObject(_preBack);
         _preBack = null;
         ObjectUtils.disposeObject(_previewImage);
         _previewImage = null;
         ObjectUtils.disposeObject(_totalVBox);
         _totalVBox = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_conditionSprite);
         _conditionSprite = null;
         ObjectUtils.disposeObject(_processSprite);
         _processSprite = null;
         ObjectUtils.disposeObject(_preSprite);
         _preSprite = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         super.dispose();
      }
   }
}

