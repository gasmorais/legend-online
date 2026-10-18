package forbiddenboss
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.manager.ForbiddenBossManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class ForbiddenRewardsItem extends Component implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _bossTxt:FilterFrameText;
      
      private var _rewardsSpanel:ScrollPanel;
      
      private var _hBox:HBox;
      
      private var _img:Bitmap;
      
      private var _receiveBtn:IconButton;
      
      private var _receivedBtn:IconButton;
      
      private var _data:ForbiddenBossTempInfo;
      
      public function ForbiddenRewardsItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,735,86);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ForbiddenRewardsItem.bg");
         _icon = ComponentFactory.Instance.creatCustomObject("forbiddenRewardsItem.icon");
         _bossTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenRewardsItem.bossTxt");
         _rewardsSpanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenRewardsItem.rewardsSpanel");
         _hBox = ComponentFactory.Instance.creatCustomObject("forbiddenRewardsItem.hBox");
         _img = ComponentFactory.Instance.creatBitmap("asset.ForbiddenRewardsItem.img");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenRewardsItem.receiveBtn");
         _receivedBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenRewardsItem.receivedBtn");
         addChild(_bg);
         addChild(_icon);
         addChild(_bossTxt);
         addChild(_rewardsSpanel);
         addChild(_img);
         addChild(_receiveBtn);
         addChild(_receivedBtn);
         _rewardsSpanel.setView(_hBox);
         _receivedBtn.enable = false;
      }
      
      public function set data(param1:ForbiddenBossTempInfo) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _icon.icon = IconFactory.getCommonIconPath(_data.bossIcon);
         _bossTxt.text = _data.bossName;
         var _loc2_:Array = _data.FirstRewards.split("|");
         _hBox.removeAllChild();
         _hBox.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc6_].split(",");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("core.normal.BaseItemView");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[0];
            _loc5_.count = _loc4_[1];
            _loc3_.data = _loc5_;
            _hBox.addChild(_loc3_);
            _loc6_++;
         }
         _hBox.commitChanges();
         _rewardsSpanel.invalidateViewport();
         switch(int(_data.firstRewardsType) - 1)
         {
            case 0:
               _receiveBtn.visible = true;
               _receivedBtn.visible = false;
               _img.visible = false;
               break;
            case 1:
               _receiveBtn.visible = false;
               _receivedBtn.visible = false;
               _img.visible = true;
               break;
            case 2:
               _receiveBtn.visible = false;
               _receivedBtn.visible = true;
               _img.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receiveBtnClickHandler);
      }
      
      private function __receiveBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         ForbiddenBossManager.instance.sendReward(_data.Id);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_bossTxt);
         _bossTxt = null;
         ObjectUtils.disposeObject(_rewardsSpanel);
         _rewardsSpanel = null;
         ObjectUtils.disposeObject(_img);
         _img = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_receivedBtn);
         _receivedBtn = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_rewardsSpanel);
         _rewardsSpanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

