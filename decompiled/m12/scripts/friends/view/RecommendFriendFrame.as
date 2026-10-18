package friends.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FriendUpdateEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.friends.RecommendInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FriendManager;
   
   public class RecommendFriendFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:VBox;
      
      private var _currentItem:RecommendFriendItem;
      
      private var _itemList:Vector.<RecommendFriendItem>;
      
      private var _data:Vector.<RecommendInfo>;
      
      private var _isScaleMove:Boolean = false;
      
      private var _bottomBg:ScaleLeftRightImage;
      
      private var _bottomAllAdd:IconButton;
      
      private var _bottomClose:IconButton;
      
      public function RecommendFriendFrame()
      {
         super();
         initView();
         initEvents();
         createItem();
         refresh();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendBG");
         var _loc1_:Sprite = new Sprite();
         var _loc7_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendTitleBG");
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendIDTxt");
         _loc3_.text = "ID";
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendNameTxt");
         _loc5_.text = LanguageMgr.GetTranslation("friends.view.RecommendFriendFrame.name");
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendLVTxt");
         _loc2_.text = LanguageMgr.GetTranslation("public.grade");
         var _loc8_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendSEXTxt");
         _loc8_.text = LanguageMgr.GetTranslation("friends.view.RecommendFriendFrame.sex");
         var _loc6_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendPowerTxt");
         _loc6_.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendFunTxt");
         _loc4_.text = LanguageMgr.GetTranslation("friends.view.RecommendFriendFrame.fun");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("friends.BottomBg");
         _bottomAllAdd = ComponentFactory.Instance.creatComponentByStylename("friends.BottomAllAddBtn");
         _bottomClose = ComponentFactory.Instance.creatComponentByStylename("friends.BottomCloseBtn");
         _loc1_.addChild(_loc7_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc5_);
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc8_);
         _loc1_.addChild(_loc6_);
         _loc1_.addChild(_loc4_);
         _loc1_.addChild(_bottomBg);
         _loc1_.addChild(_bottomAllAdd);
         _loc1_.addChild(_bottomClose);
         _list = ComponentFactory.Instance.creatComponentByStylename("friends.RecommendVbox");
         addToContent(_bg);
         addToContent(_loc1_);
         addToContent(_list);
         escEnable = true;
         _loc1_.x = 3;
         _loc1_.y = 5;
         titleText = LanguageMgr.GetTranslation("friends.view.RecommendFriendFrame.title");
         _itemList = new Vector.<RecommendFriendItem>();
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_respose);
         FriendManager.getInstance().addEventListener("UPDATE_RECOMONDLIST",__updateListHandler);
         _bottomAllAdd.addEventListener("click",__bottomAllAddHandler);
         _bottomClose.addEventListener("click",__bottomCloseHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_respose);
         FriendManager.getInstance().removeEventListener("UPDATE_RECOMONDLIST",__updateListHandler);
         if(_bottomAllAdd)
         {
            _bottomAllAdd.removeEventListener("click",__bottomAllAddHandler);
         }
         if(_bottomClose)
         {
            _bottomClose.removeEventListener("click",__bottomCloseHandler);
         }
      }
      
      private function __bottomAllAddHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:RecommendInfo = null;
         SoundManager.instance.play("022");
         _data = FriendManager.getInstance().recommendList;
         while(_loc4_ < _data.length)
         {
            _loc3_ = Boolean(FriendManager.getInstance().sendAddFriendRequest(_data[_loc4_].name,1));
            if(_loc3_)
            {
               _loc2_ = _data[_loc4_] as RecommendInfo;
               changeState(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function changeState(param1:RecommendInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RecommendInfo = null;
         var _loc2_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc3_].data as RecommendInfo;
            if(_loc4_.id == param1.id)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ >= 0)
         {
            _itemList[_loc3_].isAddFriend = false;
         }
      }
      
      private function __bottomCloseHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __updateListHandler(param1:FriendUpdateEvent) : void
      {
         refresh();
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function _itemClick(param1:MouseEvent) : void
      {
         var _loc2_:RecommendFriendItem = param1.currentTarget as RecommendFriendItem;
         if(_currentItem)
         {
            _currentItem.selected = false;
         }
         _currentItem = _loc2_;
         _currentItem.selected = true;
      }
      
      private function _scaleMoveToFriendBtn() : void
      {
         isScaleMove = false;
         var _loc1_:Point = new Point(StageReferance.stageWidth - 250,StageReferance.stageHeight - 30);
         TweenMax.to(this,0.5,{
            "scaleX":0.01,
            "scaleY":0.01,
            "x":_loc1_.x,
            "y":_loc1_.y,
            "onComplete":_moveComplete
         });
      }
      
      private function _moveComplete() : void
      {
         MainToolBar.instance.blinkFriendBtn();
         dispose();
      }
      
      public function createItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RecommendFriendItem = null;
         while(_loc2_ < 10)
         {
            _loc1_ = new RecommendFriendItem();
            _loc1_.filterString = "core.DefaultFilter,core.LightFilter";
            _loc1_.index = _loc2_;
            _itemList.push(_loc1_);
            _list.addChild(_loc1_);
            _loc1_.addEventListener("click",_itemClick);
            _loc2_++;
         }
      }
      
      private function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RecommendFriendItem = null;
         _data = FriendManager.getInstance().recommendList;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            if(_loc1_ && _loc2_ < _data.length)
            {
               _loc1_.data = _data[_loc2_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc2_++;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function set isScaleMove(param1:Boolean) : void
      {
         _isScaleMove = param1;
      }
      
      public function get isScaleMove() : Boolean
      {
         return _isScaleMove;
      }
      
      public function getAddBtnByIndex(param1:int) : TextButton
      {
         if(param1 < _itemList.length)
         {
            return _itemList[param1].addBtn;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         for each(var _loc1_:RecommendFriendItem in _itemList)
         {
            _loc1_.removeEventListener("click",_itemClick);
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList.splice(0,_itemList.length);
         _itemList = null;
         _currentItem = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

