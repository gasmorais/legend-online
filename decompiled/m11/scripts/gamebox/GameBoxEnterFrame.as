package gamebox
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import gamebox.view.GameBoxExchangeView;
   import gamebox.view.GameBoxItemView;
   import gamebox.vo.GameBoxGameVO;
   import manager.LanguageMgr;
   import managers.GameBoxManager;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class GameBoxEnterFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _exchangeView:GameBoxExchangeView;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _itemObj:Object = {};
      
      private var _itemCanvas:Sprite;
      
      private var _hasGameDayArr:Array;
      
      private var _centerDay:int;
      
      private var _leftDay:int;
      
      private var _rightDay:int;
      
      private var _gameDatas:Array;
      
      private var _gameItems:Array;
      
      private var _centerGameItemIndex:int = 1;
      
      public function GameBoxEnterFrame()
      {
         GameBoxManager.instance.getData();
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,940,560);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gamebox.GameBoxEnterFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamebox.Back");
         _exchangeView = ComponentFactory.Instance.creatCustomObject("gamebox.GameBoxExchangeView");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("gamebox.gameitem.LeftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("gamebox.gameitem.RightBtn");
         addToContent(_bg);
         addToContent(_exchangeView);
         initItem();
         addToContent(_leftBtn);
         addToContent(_rightBtn);
      }
      
      private function initItem() : void
      {
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:GameBoxGameVO = null;
         var _loc9_:GameBoxItemView = null;
         _gameDatas = [];
         _gameItems = [];
         _hasGameDayArr = [];
         _itemCanvas = new Sprite();
         _itemCanvas.x = 3;
         _itemCanvas.y = 25;
         _itemCanvas.scrollRect = new Rectangle(0,0,755,487);
         addToContent(_itemCanvas);
         var _loc8_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Game_List");
         if(_loc8_ == null)
         {
            _loc4_ = "1,1,208006,208006,208006|2,1,208006,208006,208006|3,4,208006,208006,208006|1,2,208006,208006,208006|3,2,208006,208006,208006|2,7,208006,208006,208006";
         }
         else
         {
            _loc4_ = _loc8_.ConfigValue;
         }
         var _loc5_:Array = _loc4_.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = String(_loc5_[_loc6_]).split(",");
            _loc2_ = int(_loc3_[1] == 0 ? -1 : _loc3_[1]);
            _loc1_ = getGameBoxGameVOByGameId(_loc3_[0]);
            if(!_loc1_)
            {
               _loc1_ = new GameBoxGameVO();
               _gameDatas.push(_loc1_);
            }
            _loc1_.gameId = _loc3_[0];
            _loc1_.openDay.push(_loc2_);
            _loc1_.setAndSort();
            _loc1_.rewards = [];
            _loc7_ = 2;
            while(_loc7_ < _loc3_.length)
            {
               _loc1_.rewards.push(_loc3_[_loc7_]);
               _loc7_++;
            }
            _loc6_++;
         }
         _gameDatas.sort(sortByDay);
         _loc6_ = 0;
         while(_loc6_ < _gameDatas.length)
         {
            _loc9_ = new GameBoxItemView();
            _loc9_.cfgData = _gameDatas[_loc6_];
            _itemCanvas.addChild(_loc9_);
            _loc9_.x = 5 + _loc6_ * 227;
            _loc9_.y = 30;
            _loc9_.scaleX = _loc9_.scaleY = 0.9;
            _loc9_.alpha = 0.5;
            _loc9_.mouseChildren = _loc9_.mouseEnabled = false;
            _gameItems.push(_loc9_);
            _loc6_++;
         }
         moveGameItem(moveInitCount);
      }
      
      private function sortByDay(param1:GameBoxGameVO, param2:GameBoxGameVO) : int
      {
         if(param1.openDay[0] < param2.openDay[0])
         {
            return -1;
         }
         if(param1.openDay[0] > param2.openDay[0])
         {
            return 1;
         }
         if(param1.gameId < param2.gameId)
         {
            return -1;
         }
         if(param1.gameId > param2.gameId)
         {
            return 1;
         }
         return 0;
      }
      
      private function getGameBoxGameVOByGameId(param1:int) : GameBoxGameVO
      {
         for each(var _loc2_:GameBoxGameVO in _gameDatas)
         {
            if(_loc2_.gameId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get moveInitCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Boolean = true;
         _loc2_ = 0;
         while(_loc2_ < _gameDatas.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _gameDatas[_loc2_].openDay.length)
            {
               if(_gameDatas[_loc2_].openDay[_loc3_] != 0)
               {
                  _loc4_ = false;
                  break;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc4_)
         {
            return _loc5_;
         }
         var _loc6_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.day);
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _gameDatas.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _gameDatas[_loc2_].openDay.length)
            {
               if(_gameDatas[_loc2_].openDay[_loc3_] == _loc6_ || _gameDatas[_loc2_].openDay[_loc3_] == 0)
               {
                  _loc5_ = _loc2_ - _centerGameItemIndex;
                  _loc1_ = true;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      private function moveGameItem(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 1;
         _loc5_ = 0;
         while(_loc5_ < Math.abs(param1))
         {
            if(param1 < 0)
            {
               _loc2_ = -1;
            }
            _centerGameItemIndex += _loc2_;
            if(_centerGameItemIndex < 0)
            {
               _centerGameItemIndex = _centerGameItemIndex = _gameItems.length - 1;
            }
            if(_centerGameItemIndex > _gameItems.length - 1)
            {
               _centerGameItemIndex = 0;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _gameItems.length)
         {
            if(_loc5_ - _centerGameItemIndex <= -2)
            {
               _gameItems[_loc5_].x = -260;
               _gameItems[_loc5_].y = 30;
               _gameItems[_loc5_].scaleX = _gameItems[_loc5_].scaleY = 0.9;
               _gameItems[_loc5_].alpha = 0.5;
               _gameItems[_loc5_].mouseEnabled = _gameItems[_loc5_].mouseChildren = false;
            }
            else if(_loc5_ - _centerGameItemIndex >= 2)
            {
               _gameItems[_loc5_].x = 760;
               _gameItems[_loc5_].y = 30;
               _gameItems[_loc5_].scaleX = _gameItems[_loc5_].scaleY = 0.9;
               _gameItems[_loc5_].alpha = 0.5;
               _gameItems[_loc5_].mouseEnabled = _gameItems[_loc5_].mouseChildren = false;
            }
            _loc5_++;
         }
         _gameItems[_centerGameItemIndex].mouseEnabled = _gameItems[_centerGameItemIndex].mouseChildren = true;
         TweenMax.to(_gameItems[_centerGameItemIndex],0.3,{
            "x":232,
            "y":5,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         var _loc3_:int = _centerGameItemIndex - 1 < 0 ? _gameItems.length - 1 : _centerGameItemIndex - 1;
         _gameItems[_loc3_].mouseEnabled = _gameItems[_loc3_].mouseChildren = false;
         TweenMax.to(_gameItems[_loc3_],0.1,{
            "x":5,
            "y":30,
            "scaleX":0.9,
            "scaleY":0.9,
            "alpha":0.5
         });
         var _loc4_:int = _centerGameItemIndex + 1 > _gameItems.length - 1 ? 0 : _centerGameItemIndex + 1;
         _gameItems[_loc4_].mouseEnabled = _gameItems[_loc4_].mouseChildren = false;
         TweenMax.to(_gameItems[_loc4_],0.1,{
            "x":495,
            "y":30,
            "scaleX":0.9,
            "scaleY":0.9,
            "alpha":0.5
         });
         _itemCanvas.setChildIndex(_gameItems[_centerGameItemIndex],_itemCanvas.numChildren - 1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _leftBtn.addEventListener("click",onLeftBtnClick);
         _rightBtn.addEventListener("click",onRightBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _leftBtn.removeEventListener("click",onLeftBtnClick);
         _rightBtn.removeEventListener("click",onRightBtnClick);
      }
      
      private function onLeftBtnClick(param1:MouseEvent) : void
      {
         moveGameItem(-1);
      }
      
      private function onRightBtnClick(param1:MouseEvent) : void
      {
         moveGameItem(1);
      }
      
      private function setItemEnabled(param1:int) : void
      {
         for(var _loc2_:String in _itemObj)
         {
            _itemObj[_loc2_].mouseEnabled = _itemObj[_loc2_].mouseChildren = false;
         }
         _itemObj[param1].mouseEnabled = _itemObj[param1].mouseChildren = true;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_exchangeView);
         _exchangeView = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeAllChildren(_itemCanvas);
         ObjectUtils.disposeObject(_itemCanvas);
         _itemCanvas = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _itemObj = null;
         _hasGameDayArr = null;
         if(_gameItems != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _gameItems.length)
            {
               ObjectUtils.disposeObject(_gameItems[_loc1_]);
               _gameItems[_loc1_] = null;
               _loc1_++;
            }
            _gameItems = null;
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

