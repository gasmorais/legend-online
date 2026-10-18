package gamehall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import gamehall.view.GameHallEastShopItemView;
   import manager.LanguageMgr;
   import mvc.module.gamehall.GameHallEastShopInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropSortInfo;
   import yishi.datas.templates.GamehallEastDropTemplate;
   import yishi.manager.TempleteManager;
   
   public class GameHallEastShopDescFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _rewardBg:Image;
      
      private var _rewardTxt:Image;
      
      private var _btnScrollPanel:ScrollPanel;
      
      private var _rewardContentBg:Image;
      
      private var _rewardContentTxt:Image;
      
      private var _contentScrollPanel:ScrollPanel;
      
      private var _spline:Image;
      
      private var _descImage:Image;
      
      private var _descTxt:FilterFrameText;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _centerGoodsListView:Sprite;
      
      public function GameHallEastShopDescFrame()
      {
         super();
         initView();
         initBtnData();
         addEvent();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.border");
         _rewardBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.rewardBg");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.rewardTxt");
         _btnScrollPanel = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.btnScrollPanel");
         _rewardContentBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.rewardContentBg");
         _rewardContentTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.rewardContentTxt");
         _contentScrollPanel = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.contentScrollPanel");
         _spline = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.spline");
         _descImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.descImage");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopDescFrame.descTxt");
         _centerGoodsListView = new Sprite();
         addToContent(_border);
         addToContent(_rewardBg);
         addToContent(_rewardTxt);
         addToContent(_btnScrollPanel);
         addToContent(_rewardContentBg);
         addToContent(_rewardContentTxt);
         addToContent(_contentScrollPanel);
         addToContent(_spline);
         addToContent(_descImage);
         addToContent(_descTxt);
         _contentScrollPanel.setView(_centerGoodsListView);
         _descTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopDescFrame.descTxt");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_btnScrollPanel);
         _btnScrollPanel = null;
         ObjectUtils.disposeObject(_rewardContentBg);
         _rewardContentBg = null;
         ObjectUtils.disposeObject(_rewardContentTxt);
         _rewardContentTxt = null;
         ObjectUtils.disposeObject(_centerGoodsListView);
         _centerGoodsListView = null;
         ObjectUtils.disposeObject(_contentScrollPanel);
         _contentScrollPanel = null;
         ObjectUtils.disposeObject(_spline);
         _spline = null;
         ObjectUtils.disposeObject(_descImage);
         _descImage = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__panelChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__panelChangeHandler);
      }
      
      private function initBtnData() : void
      {
         var _loc5_:Sprite = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:CommonDropSortInfo = null;
         var _loc7_:SelectedIconTextButton = null;
         var _loc2_:Array = TempleteManager.instance.gamehallEastShopTempCate.getTemplatesAry();
         if(_loc2_)
         {
            _loc5_ = new Sprite();
            _loc1_ = int(_loc2_.length);
            _loc3_ = 6;
            _btnGroup = new SelectedButtonGroup();
            _loc6_ = Math.ceil(_loc1_ / _loc3_);
            _btnScrollPanel.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc8_ = _loc2_[_loc4_] as CommonDropSortInfo;
               _loc7_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.view.GameHallEastShopDescBtnItem.btn");
               _loc7_.text = setTitleText(_loc8_.rankTitle);
               _loc7_.x = 2 + _loc4_ % _loc3_ * 112;
               _loc7_.y = int(_loc4_ / _loc3_) * 38;
               _loc5_.addChild(_loc7_);
               _btnGroup.addSelectItem(_loc7_);
               _loc4_++;
            }
            if(_loc6_ > 0)
            {
               _loc5_.scrollRect = new Rectangle(0,0,710,_loc6_ * 38);
            }
            _btnScrollPanel.setView(_loc5_);
            _btnScrollPanel.invalidateViewport();
            _btnScrollPanel.commitChanges();
            _btnGroup.selectIndex = 0;
            __panelChangeHandler(null);
         }
      }
      
      public function setTitleText(param1:String) : String
      {
         var _loc2_:String = null;
         if(!param1)
         {
            return "";
         }
         var _loc3_:Array = param1.split(",");
         if(_loc3_.length > 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("gamehall.btnTxt2",_loc3_[0],_loc3_[1]);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("gamehall.btnTxt1",_loc3_[0]);
         }
         return _loc2_;
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         var _loc11_:int = 0;
         var _loc2_:CommonDropSortInfo = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:GameHallEastShopItemView = null;
         var _loc4_:GamehallEastDropTemplate = null;
         var _loc9_:int = 0;
         SoundManager.instance.play("022");
         var _loc5_:Array = TempleteManager.instance.gamehallEastShopTempCate.getTemplatesAry();
         var _loc6_:IntPoint = new IntPoint();
         if(_loc5_)
         {
            _loc11_ = int(_btnGroup.selectIndex);
            _loc2_ = _loc5_[_loc11_] as CommonDropSortInfo;
            if(_loc2_)
            {
               _loc7_ = _loc2_.dropAry;
               _loc7_.sortOn("id",16);
               if(!_loc7_)
               {
                  return;
               }
               _loc8_ = 3;
               _loc10_ = Math.ceil(_loc7_.length / _loc8_);
               if(_centerGoodsListView && _centerGoodsListView.numChildren > 0)
               {
                  _centerGoodsListView.removeChildren(0,_centerGoodsListView.numChildren - 1);
               }
               _centerGoodsListView = new Sprite();
               _contentScrollPanel.beginChanges();
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc3_ = new GameHallEastShopItemView();
                  _loc4_ = _loc7_[_loc9_] as GamehallEastDropTemplate;
                  _loc3_.x = 2 + _loc9_ % _loc8_ * 250;
                  _loc3_.y = int(_loc9_ / _loc8_) * 100;
                  _loc3_.setHasGetVisible = false;
                  if(_loc4_)
                  {
                     _loc3_.data = getGameHallEastShopInfo(_loc4_.itemId,_loc4_.count,_loc4_.isShow);
                  }
                  _centerGoodsListView.addChild(_loc3_);
                  _loc9_++;
               }
               if(_loc10_ > 0)
               {
                  _centerGoodsListView.scrollRect = new Rectangle(0,0,765,_loc10_ * 100);
               }
               _contentScrollPanel.setView(_centerGoodsListView);
               _contentScrollPanel.invalidateViewport();
               _contentScrollPanel.commitChanges();
               _contentScrollPanel.viewPort.viewPosition = _loc6_;
            }
         }
      }
      
      private function getGameHallEastShopInfo(param1:int, param2:int, param3:int) : GameHallEastShopInfo
      {
         var _loc4_:GameHallEastShopInfo = new GameHallEastShopInfo();
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = param1;
         _loc4_.goodsInfo = _loc5_;
         _loc4_.remainNumber = param2;
         _loc4_.isShow = param3;
         return _loc4_;
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
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.descTxt");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,810,630);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

