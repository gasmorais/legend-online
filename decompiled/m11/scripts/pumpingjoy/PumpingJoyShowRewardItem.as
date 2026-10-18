package pumpingjoy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.pumpingegg.PumpingJoyRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class PumpingJoyShowRewardItem extends Component
   {
      
      private var redBackMc:MovieClip;
      
      private var back:ScaleFrameImage;
      
      private var item:BaseItemView;
      
      private var itemSprite:Sprite;
      
      private var _data:PumpingJoyRewardInfo;
      
      public function PumpingJoyShowRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         redBackMc = ComponentFactory.Instance.creatCustomObject("PumpingJoyShowRewardItem.redBackMc");
         back = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyRewardItem.back");
         item = ComponentFactory.Instance.creatCustomObject("PumpingJoyRewardItem.item");
         addChild(back);
         addChild(redBackMc);
         addChild(item);
         item.mask = createSprite();
         redBackMc.stop();
         redBackMc.visible = false;
         redBackMc.mouseChildren = redBackMc.mouseEnabled = false;
      }
      
      private function createSprite() : Sprite
      {
         itemSprite = new Sprite();
         itemSprite.graphics.beginFill(16777215,1);
         itemSprite.graphics.drawRect(28,15,50,38);
         itemSprite.graphics.endFill();
         addChild(itemSprite);
         itemSprite.mouseChildren = itemSprite.mouseEnabled = false;
         return itemSprite;
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
         back.setFrame(_data.profile);
         if(_data.profile == 3)
         {
            redBackMc.gotoAndPlay(1);
            redBackMc.visible = true;
         }
         else
         {
            redBackMc.stop();
            redBackMc.visible = false;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.tempId;
         _loc2_.count = _data.count;
         item.data = _loc2_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(redBackMc);
         redBackMc = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(item);
         item = null;
         ObjectUtils.disposeObject(itemSprite);
         itemSprite = null;
         super.dispose();
      }
   }
}

