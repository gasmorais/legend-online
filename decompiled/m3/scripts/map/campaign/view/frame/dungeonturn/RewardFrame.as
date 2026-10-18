package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DungeoTurnManager;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class RewardFrame extends Frame
   {
      
      private var _bg:Image;
      
      private var _cancel:IconButton;
      
      private var _getReward:IconButton;
      
      private var _normalBox:ScaleFrameImage;
      
      private var _bossBox:ScaleFrameImage;
      
      private var _normalBoxPicText:Image;
      
      private var _bossBoxPicText:Image;
      
      private var _normalBring:Image;
      
      private var _bossBring:Image;
      
      private var _multi1:Image;
      
      private var _multi2:Image;
      
      private var _numBmp:BitmapData;
      
      private var _numImg1:Sprite;
      
      private var _numImg2:Sprite;
      
      public function RewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.RewardFrame.bg");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.RewardFrame.cancel");
         _getReward = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.RewardFrame.getReward");
         _bossBox = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.BottomBg.bossBox2");
         _normalBox = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.DungeonTurnFrame.BottomBg.normalBox2");
         _normalBoxPicText = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.normalBoxTxt2");
         _bossBoxPicText = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.bossBoxTxt2");
         _bossBring = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.bossBring2");
         _normalBring = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.BottomBg.normalBring2");
         _multi1 = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.sign2");
         _multi2 = ComponentFactory.Instance.creatComponentByStylename("dungeoturn.sign3");
         _numBmp = ComponentFactory.Instance.creatBitmapData("asset.dungeoturn.num");
         _numImg1 = new Sprite();
         _numImg1.x = 261;
         _numImg1.y = 62;
         _numImg2 = new Sprite();
         _numImg2.x = 261;
         _numImg2.y = 147;
         addToContent(_bg);
         addToContent(_cancel);
         addToContent(_getReward);
         addToContent(_numImg1);
         addToContent(_numImg2);
         addToContent(_multi1);
         addToContent(_multi2);
         addToContent(_bossBring);
         addToContent(_normalBring);
         addToContent(_bossBox);
         addToContent(_normalBox);
         addToContent(_normalBoxPicText);
         addToContent(_bossBoxPicText);
         titleText = LanguageMgr.GetTranslation("dungeoturn.getReward");
         if(!DungeoTurnManager.instance.model.hasGeted && Boolean(DungeoTurnManager.instance.model.hasReward) && DungeoTurnManager.instance.model.bossBoxNum != 0)
         {
            _getReward.enable = true;
         }
         else
         {
            _getReward.enable = false;
         }
         setbox();
      }
      
      private function setbox() : void
      {
         _bossBox.setFrame(DungeoTurnManager.instance.model.bossBoxLevel);
         _normalBox.setFrame(DungeoTurnManager.instance.model.normalBoxLevel);
         NumberViewUtils.refreshValue(DungeoTurnManager.instance.model.bossBoxNum,_numImg1,_numBmp,21,24,21,21,"0123456789");
         NumberViewUtils.refreshValue(DungeoTurnManager.instance.model.normalBoxNum,_numImg2,_numBmp,21,24,21,21,"0123456789");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _getReward.addEventListener("click",_getRewardClickHandler);
         _cancel.addEventListener("click",_cancelClickHandler);
         NotificationManager.instance.addEventListener("DUNGEO_GET_REWARD",closeFrame);
      }
      
      private function _getRewardClickHandler(param1:MouseEvent) : void
      {
         DungeoTurnManager.instance.obtainReward();
      }
      
      private function _cancelClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function closeFrame(param1:Event) : void
      {
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_getReward)
         {
            _getReward.removeEventListener("click",_getRewardClickHandler);
         }
         if(_cancel)
         {
            _cancel.removeEventListener("click",_cancelClickHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_cancel);
         _cancel = null;
         ObjectUtils.disposeObject(_getReward);
         _getReward = null;
         ObjectUtils.disposeObject(_normalBox);
         _normalBox = null;
         ObjectUtils.disposeObject(_bossBox);
         _bossBox = null;
         ObjectUtils.disposeObject(_normalBoxPicText);
         _normalBoxPicText = null;
         ObjectUtils.disposeObject(_bossBoxPicText);
         _bossBoxPicText = null;
         ObjectUtils.disposeObject(_normalBring);
         _normalBring = null;
         ObjectUtils.disposeObject(_bossBring);
         _bossBring = null;
         ObjectUtils.disposeObject(_multi1);
         _multi1 = null;
         ObjectUtils.disposeObject(_multi2);
         _multi2 = null;
         ObjectUtils.disposeObject(_numImg1);
         _numImg1 = null;
         ObjectUtils.disposeObject(_numImg2);
         _numImg2 = null;
         super.dispose();
      }
   }
}

