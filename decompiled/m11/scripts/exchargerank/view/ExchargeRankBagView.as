package exchargerank.view
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class ExchargeRankBagView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _panel:ScrollPanel;
      
      private var _totalVBox:VBox;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<DisplayObject>;
      
      private var _title:GradientText;
      
      private var _time:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _conditionImage:Bitmap;
      
      private var _condition:FilterFrameText;
      
      private var _rewardImage:MutipleImage;
      
      private var _data:ExchargeData;
      
      private var _bg:ScaleBitmapImage;
      
      private var _conditionSprite:Sprite;
      
      private var _rewardSprite:Sprite;
      
      public function ExchargeRankBagView()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargerankBagView.Bg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("exchargeRank.exchargerankBagView.Back");
         _title = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargerankBagView.title");
         _time = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargerankBagView.time");
         _conditionImage = ComponentFactory.Instance.creatBitmap("asset.exchargeRanking.conditionImage");
         _condition = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargerankBagView.condition");
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rewardImage");
         _content = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargerankBagView.content");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankingRightView.totalVBox");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankingRightView.itemVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("exchargeRankingRightView.panel");
         _title.text = LanguageMgr.GetTranslation("exchargerank.exchargerankBagView.title");
         addChild(_bg);
         addChild(_back);
         addChild(_title);
         addChild(_time);
         addChild(_condition);
         addChild(_content);
         addChild(_conditionImage);
         addChild(_panel);
         _conditionSprite = new Sprite();
         _conditionSprite.addChild(_conditionImage);
         _conditionSprite.addChild(_condition);
         _itemList = new Vector.<DisplayObject>();
         _panel.setView(_totalVBox);
      }
      
      public function get data() : ExchargeData
      {
         return _data;
      }
      
      public function set data(param1:ExchargeData) : void
      {
         var _loc6_:IntPoint = null;
         var _loc3_:IntPoint = null;
         var _loc7_:int = 0;
         var _loc4_:Boolean = false;
         var _loc8_:ExchargeRewardItem = null;
         cleanView();
         if(_data == param1 && _panel && _panel.viewPort)
         {
            _loc3_ = _panel.viewPort.viewPosition;
            _loc6_ = new IntPoint(_loc3_.x,_loc3_.y);
         }
         else
         {
            _loc6_ = new IntPoint();
         }
         _data = param1;
         if(param1 == null)
         {
            return;
         }
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankingRightView.itemVBox");
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("exchargerank.rewardImage");
         var _loc5_:String = DateFormatter.transDate(_data.startTime / 1000);
         var _loc2_:String = DateFormatter.transDate(_data.endTime / 1000);
         _time.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeRankBag.timeText",_loc5_.toString(),_loc2_.toString());
         _content.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeRankBag.contentText",_data.condition);
         _condition.text = _data.describe;
         _totalVBox.addChild(_time);
         _totalVBox.addChild(_content);
         _conditionSprite.x = 0;
         _conditionSprite.y = 2;
         _totalVBox.addChild(_conditionSprite);
         _totalVBox.addChild(_rewardImage);
         _totalVBox.addChild(_itemVBox);
         _loc7_ = 0;
         _loc4_ = false;
         while(_loc7_ < param1.bagList.length)
         {
            _loc8_ = new ExchargeRewardItem();
            _loc8_.data = param1.bagList[_loc7_];
            _itemVBox.addChild(_loc8_);
            _itemList.push(_loc8_);
            _loc7_++;
         }
         _totalVBox.refreshChildPos();
         _panel.invalidateViewport();
         _panel.viewPort.viewPosition = _loc6_;
      }
      
      public function cleanView() : void
      {
         _time.text = "";
         _condition.htmlText = "";
         _content.htmlText = "";
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         if(_totalVBox)
         {
            _totalVBox.disposeAllChildren();
         }
         _panel.invalidateViewport();
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_totalVBox);
         _totalVBox = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_condition);
         _condition = null;
         ObjectUtils.disposeObject(_conditionImage);
         _conditionImage = null;
         ObjectUtils.disposeObject(_rewardImage);
         _rewardImage = null;
         _data = null;
         ObjectUtils.disposeObject(_conditionSprite);
         _conditionSprite = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

