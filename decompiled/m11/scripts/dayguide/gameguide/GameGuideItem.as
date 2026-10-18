package dayguide.gameguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.gameguide.GameGuideInfo;
   import yishi.SwitchPageHelp;
   
   public class GameGuideItem extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _titleText:FilterFrameText;
      
      private var _skipText:FilterFrameText;
      
      private var _describeText:FilterFrameText;
      
      private var _skipArea:Sprite;
      
      private var _hBox:HBox;
      
      private var _data:GameGuideInfo;
      
      public function GameGuideItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("gameguide.GameGuideItemBack");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("gameguide.GameGuideItem.titleText");
         _skipText = ComponentFactory.Instance.creatComponentByStylename("gameguide.GameGuideItemBack.skipText");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("gameguide.GameGuideItemBack.describeText");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("gameguide.HBox");
         _skipArea = new Sprite();
         _skipArea.buttonMode = true;
         addChild(_back);
         addChild(_titleText);
         addChild(_skipText);
         addChild(_skipArea);
         addChild(_describeText);
         addChild(_hBox);
         _skipText.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
      }
      
      private function setHitArea() : void
      {
         _skipArea.graphics.clear();
         _skipArea.graphics.beginFill(0,0);
         _skipArea.graphics.drawRect(0,0,_skipText.width,_skipText.height);
         _skipArea.x = _skipText.x;
         _skipArea.y = _skipText.y;
      }
      
      public function set data(param1:GameGuideInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         _data = param1;
         if(_data == null)
         {
            return;
         }
         _titleText.text = _data.title;
         _describeText.text = _data.describe;
         if(_describeText.numLines == 2)
         {
            _describeText.y = 48;
         }
         else if(_describeText.numLines > 2)
         {
            _describeText.y = 41;
         }
         _hBox.disposeAllChildren();
         _hBox.removeAllChild();
         _loc2_ = 0;
         while(_loc2_ < _data.starCount)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.StarLevelImg");
            _hBox.addChild(_loc3_);
            _loc2_++;
         }
         setHitArea();
      }
      
      private function initEvent() : void
      {
         _skipArea.addEventListener("click",__skipHandler);
      }
      
      private function __skipHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data == null)
         {
            return;
         }
         switch(_data.key)
         {
            case "EXP_GET_01":
               SwitchPageHelp.gotoOfferRewardFrame();
               break;
            case "EXP_GET_02":
            case "EQUIP_GET_02":
               SwitchPageHelp.gotoHeroDoor();
               break;
            case "EXP_GET_03":
            case "GOLD_GET_03":
            case "SOUL_GET_03":
            case "CRYSTAL_GET_01":
            case "CRYSTAL_GET_02":
               SwitchPageHelp.gotoFarmFrame();
               break;
            case "EXP_GET_04":
            case "EQUIP_GET_03":
               SwitchPageHelp.gotoMazeFrame();
               break;
            case "EXP_GET_05":
            case "EQUIP_GET_05":
               SwitchPageHelp.gotoSingleCampaign();
               break;
            case "EQUIP_GET_01":
               SwitchPageHelp.gotoMarkeFrame();
               break;
            case "EQUIP_GET_04":
               SwitchPageHelp.gotoPvpFrame();
               break;
            case "STORE_GET_01":
            case "GOLD_USE_01":
               SwitchPageHelp.gotoStoreFrame("STORE_PANEL_INTENSIFY");
               break;
            case "GOLD_GET_02":
            case "SOUL_GET_02":
               SwitchPageHelp.gotoWorldBossFrame();
               break;
            case "GOLD_GET_04":
            case "CRYSTAL_GET_03":
            case "GOLD_GET_05":
            case "SOUL_GET_04":
               SwitchPageHelp.gotoOuterCity();
               break;
            case "GOLD_USE_02":
               SwitchPageHelp.gotoConsortiaFrame();
               break;
            case "GOLD_USE_03":
               SwitchPageHelp.gotoStarFrame();
               break;
            case "SOUL_USE_01":
            case "SOUL_USE_02":
               SwitchPageHelp.gotoCasernFrame();
               break;
            case "CRYSTAL_USE_01":
            case "CRYSTAL_USE_02":
               SwitchPageHelp.gotoSeminaryFrame();
         }
      }
      
      private function removeEvent() : void
      {
         if(_skipArea)
         {
            _skipArea.removeEventListener("click",__skipHandler);
         }
      }
      
      public function setPageNumber(param1:int, param2:int) : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_skipText);
         _skipText = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(_skipArea)
         {
            _skipArea.graphics.clear();
         }
         _skipArea = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

