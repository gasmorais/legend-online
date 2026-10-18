package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.dayGuide.DailyItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class DailyRightView extends Frame
   {
      
      private var _data:DailyItemInfo;
      
      private var _describe:FilterFrameText;
      
      private var _rewardImage:MutipleImage;
      
      private var _mask:Shape;
      
      private var _goodsPanel:ScrollPanel;
      
      private var _goodsBox:VBox;
      
      private var _sp1:Sprite;
      
      private var _sp2:Sprite;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _scrollPanel:ScrollPanel;
      
      public function DailyRightView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("dayguide.DailyRightView.titleText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("dailyRightView.describeText");
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("dailyRightView.rewardImage");
         _goodsPanel = ComponentFactory.Instance.creatComponentByStylename("dailyRightView.goodsPanel");
         _goodsBox = ComponentFactory.Instance.creatComponentByStylename("dailyRightView.goodsBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("daily.rightScrollPanel");
         creatMask();
         _sp1 = new Sprite();
         _sp2 = new Sprite();
         _describe.mask = _mask;
         addToContent(_describe);
         addToContent(_rewardImage);
         addToContent(_goodsPanel);
         _goodsPanel.setView(_goodsBox);
         _goodsBox.addChild(_sp1);
         _goodsBox.addChild(_sp2);
         _itemList = new Vector.<BaseItemView>();
      }
      
      private function creatMask() : void
      {
         _mask = new Shape();
         _mask.graphics.clear();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRect(0,0,165,210);
         _mask.x = _describe.x;
         _mask.y = _describe.y;
         addToContent(_mask);
      }
      
      public function set data(param1:DailyItemInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         _describe.text = _data.Detail;
         addGoods();
      }
      
      private function addGoods() : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         cleanItem();
         if(StringHelper.isNullOrEmpty(_data.DropList) || _data.DropList == "0")
         {
            return;
         }
         var _loc1_:Array = _data.DropList.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[_loc3_];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("dayGuide.BaseItemView");
            _loc2_.data = _loc4_;
            _itemList.push(_loc2_);
            _loc2_.scaleX = _loc2_.scaleY = 0.9;
            _loc2_.buttonMode = false;
            if(_loc3_ < 5)
            {
               _sp1.addChild(_loc2_);
               _loc2_.x = 43 * _loc3_;
            }
            else
            {
               _sp2.addChild(_loc2_);
               _loc2_.x = 43 * (_loc3_ - 5);
            }
            _loc3_++;
         }
         _goodsBox.refreshChildPos();
         _goodsPanel.invalidateViewport();
      }
      
      private function cleanItem() : void
      {
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         _mask = null;
         _sp1 = null;
         _sp2 = null;
         cleanItem();
         _itemList = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_rewardImage);
         _rewardImage = null;
         ObjectUtils.disposeObject(_goodsPanel);
         _goodsPanel = null;
         ObjectUtils.disposeObject(_goodsBox);
         _goodsBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

