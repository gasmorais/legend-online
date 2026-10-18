package pumpingjoy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.pumpingegg.PumpingJoyRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class PumpingJoyRewardItem extends Component
   {
      
      private var redBackMc:MovieClip;
      
      private var ballMc:MovieClip;
      
      private var back:ScaleFrameImage;
      
      private var item:BaseItemView;
      
      private var itemSprite:Sprite;
      
      private var openBtn:BaseButton;
      
      private var _data:PumpingJoyRewardInfo;
      
      private var _hasOpen:Boolean = false;
      
      public function PumpingJoyRewardItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         redBackMc = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardItem.redBackMc");
         item = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardItem.item");
         openBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardItem.openBtn");
         addChild(redBackMc);
         addChild(item);
         item.x = 25;
         addChild(openBtn);
         item.mask = createSprite();
         redBackMc.play();
         redBackMc.visible = true;
         redBackMc.mouseChildren = redBackMc.mouseEnabled = false;
      }
      
      private function createSprite() : Sprite
      {
         itemSprite = new Sprite();
         itemSprite.graphics.beginFill(16777215,1);
         itemSprite.graphics.drawRect(25,15,50,42);
         itemSprite.graphics.endFill();
         addChild(itemSprite);
         itemSprite.mouseChildren = itemSprite.mouseEnabled = false;
         return itemSprite;
      }
      
      private function addEvent() : void
      {
         openBtn.addEventListener("click",__openClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(openBtn)
         {
            openBtn.removeEventListener("click",__openClickHandler);
         }
      }
      
      private function __openClickHandler(param1:MouseEvent) : void
      {
         openReward();
      }
      
      public function openReward() : void
      {
         if(hasOpen)
         {
            return;
         }
         openBtn.enable = false;
         ballMc.addFrameScript(ballMc.totalFrames - 1,movieOverHandler);
         ballMc.gotoAndPlay(1);
      }
      
      private function movieOverHandler() : void
      {
         item.visible = true;
         ballMc.stop();
         hasOpen = true;
         openBtn.enable = false;
         redBackMc.stop();
         redBackMc.visible = false;
         MsgMan.notifyObserver("PUMPING_JOY_SHOW_REWARD",data.id);
      }
      
      public function get data() : PumpingJoyRewardInfo
      {
         return _data;
      }
      
      public function set data(param1:PumpingJoyRewardInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         ballMc = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardItem.ballMc" + _data.profile);
         addChildAt(ballMc,0);
         ballMc.stop();
         ballMc.mouseChildren = ballMc.mouseEnabled = false;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.tempId;
         _loc2_.count = _data.count;
         item.data = _loc2_;
         item.visible = false;
         openBtn.enable = !hasOpen;
         if(_data.profile == 3 && !hasOpen)
         {
            redBackMc.gotoAndPlay(1);
            redBackMc.visible = true;
         }
         else
         {
            redBackMc.stop();
            redBackMc.visible = false;
         }
      }
      
      public function get hasOpen() : Boolean
      {
         return _hasOpen;
      }
      
      public function set hasOpen(param1:Boolean) : void
      {
         _hasOpen = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(redBackMc);
         redBackMc = null;
         ObjectUtils.disposeViolentMc(ballMc);
         ballMc = null;
         ObjectUtils.disposeObject(item);
         item = null;
         ObjectUtils.disposeObject(openBtn);
         openBtn = null;
         super.dispose();
      }
   }
}

