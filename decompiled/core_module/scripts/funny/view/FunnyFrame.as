package funny.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyData;
   import funny.groupbuy.GroupBuyListBar;
   import funny.groupbuy.GroupBuyView;
   import funny.mountact.MountActView;
   import funny.newyearact.NewYearPayActView;
   import manager.LanguageMgr;
   import managers.ActivityManager;
   import managers.FunnyManager;
   import managers.GodDessManager;
   import managers.MountActSocketOutManager;
   import managers.NewYearSocketOutManager;
   import managers.ShopManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   
   public class FunnyFrame extends Frame implements IManualSize
   {
      
      private var _back:Scale9CornerImage;
      
      private var _leftBack:Bitmap;
      
      private var _gap:MutipleImage;
      
      private var _leftVBox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _funnyRightView:FunnyRightView;
      
      private var _activityBtn:FunnyLeftButton;
      
      private var _current:int = 1;
      
      private var _total:int = 1;
      
      private var _pageSp:Sprite;
      
      private var _pageBack:Bitmap;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageText:FilterFrameText;
      
      private var _showData:Vector.<FunnyData>;
      
      private var _index:int = -1;
      
      private var _num:int = 6;
      
      private var _groupBuyView:GroupBuyView;
      
      private var _groupBuyBtn:FunnyLeftButton;
      
      private var _groupBuyListBar:GroupBuyListBar;
      
      private var _isGroupBuy:Boolean = false;
      
      private var _groupBuyArr:Array;
      
      private var _newYearActView:NewYearPayActView;
      
      private var _mountActView:MountActView;
      
      private var _startNum:int;
      
      private var _endNum:int;
      
      public function FunnyFrame()
      {
         FunnyManager.instance.model.canShine = false;
         FunnyManager.instance.sendGetBag(1);
         FunnyManager.instance.sendGetActiveBagStatus(ActivityManager.Instance.activityList);
         super();
         isShowGroupBuyView();
         initShowData();
         initView();
         initEvent();
         refreshView();
         if(_showData.length > 0)
         {
            _selectedBtnGroup.selectIndex = 1;
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,765,515);
      }
      
      private function isShowGroupBuyView() : void
      {
         _groupBuyArr = ShopManager.Instance.getGroupBuyInfo();
         if(_groupBuyArr && _groupBuyArr.length > 0)
         {
            _isGroupBuy = true;
            if(_groupBuyArr.length <= 2)
            {
               _num = 4;
            }
            else if(_groupBuyArr.length > 2 && _groupBuyArr.length <= 4)
            {
               _num = 3;
            }
            else if(_groupBuyArr.length > 4)
            {
               _num = 2;
            }
         }
         else
         {
            _isGroupBuy = false;
            _num = 6;
         }
      }
      
      private function initShowData() : void
      {
         var _loc7_:int = 0;
         var _loc4_:FunnyData = null;
         var _loc1_:FunnyData = null;
         var _loc9_:FunnyData = null;
         var _loc5_:FunnyData = null;
         var _loc6_:int = 0;
         var _loc2_:FunnyData = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         _showData = new Vector.<FunnyData>();
         if(activityList.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < activityList.length)
            {
               _loc4_ = new FunnyData();
               _loc4_.id = activityList[_loc7_].activeId;
               if(activityList[_loc7_].hasKey != 360)
               {
                  _loc4_.type = 1003;
                  if(activityList[_loc7_].status == 2 || activityList[_loc7_].status == 1)
                  {
                     _loc4_.anyToGet = false;
                  }
                  else
                  {
                     _loc4_.anyToGet = true;
                  }
                  _loc4_.title = activityList[_loc7_].title;
                  _showData.push(_loc4_);
               }
               _loc7_++;
            }
         }
         if(ShopManager.Instance.model.getTimeBuyList(0).length > 0)
         {
            _loc1_ = new FunnyData();
            _loc1_.id = "HOT_BUY_ID";
            _loc1_.type = 1002;
            _loc1_.title = LanguageMgr.GetTranslation("funny.view.FunnyFrame.hotBuy.title");
            _showData.push(_loc1_);
         }
         if(ShopManager.Instance.model.getTimeBuyList(1).length > 0)
         {
            _loc9_ = new FunnyData();
            _loc9_.id = "VIP_BUY_ID";
            _loc9_.type = 1004;
            _loc9_.title = LanguageMgr.GetTranslation("funny.view.FunnyFrame.vipBuy.title");
            _showData.push(_loc9_);
         }
         if(GodDessManager.instance.model.doubleOpen)
         {
            _loc5_ = new FunnyData();
            _loc5_.id = "232";
            _loc5_.type = 232;
            _loc5_.title = LanguageMgr.GetTranslation("funny.view.FunnyFrame.goddessDoubleForge.title");
            _showData.push(_loc5_);
         }
         _loc6_ = 0;
         while(_loc6_ < funnyData.length)
         {
            if(funnyData[_loc6_])
            {
               if(!(funnyData[_loc6_].showEnd < playerModel.nowDate || funnyData[_loc6_].showStart > playerModel.nowDate))
               {
                  if(!(funnyData[_loc6_].type == 4 && !playerInfo.isBackPlayer))
                  {
                     if(!(funnyData[_loc6_].type == 1007 && !playerInfo.isBackPlayer))
                     {
                        if(funnyData[_loc6_].type != 196)
                        {
                           if(funnyData[_loc6_].type != 67)
                           {
                              if(funnyData[_loc6_].type != 197)
                              {
                                 if(funnyData[_loc6_].type != 73)
                                 {
                                    if(funnyData[_loc6_].type != 131)
                                    {
                                       if(funnyData[_loc6_].type != 201)
                                       {
                                          if(funnyData[_loc6_].type != 145)
                                          {
                                             if(funnyData[_loc6_].type != 2500)
                                             {
                                                if(funnyData[_loc6_].type != 2501)
                                                {
                                                   if(funnyData[_loc6_].type != 231)
                                                   {
                                                      _showData.push(funnyData[_loc6_]);
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
         if(_isGroupBuy == false)
         {
            _total = Math.ceil(_showData.length / 6);
         }
         else
         {
            _total = Math.ceil((_showData.length - _num) / 6) + 1;
         }
         _loc8_ = 0;
         while(_loc8_ < _showData.length)
         {
            if(_showData[_loc8_].type == 186)
            {
               _loc2_ = _showData[_loc8_];
               _loc3_ = _loc8_;
            }
            _loc8_++;
         }
         if(_loc2_)
         {
            _showData.splice(_loc3_,1);
            _showData.unshift(_loc2_);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get activityList() : Array
      {
         return ActivityManager.Instance.activityList;
      }
      
      private function get funnyData() : Vector.<FunnyData>
      {
         return FunnyManager.instance.model.data;
      }
      
      private function initView() : void
      {
         var _loc1_:String = null;
         if(ComponentSetting.isZhanQu)
         {
            _loc1_ = "mainBar.TopToolsBar.funnyBtn.tipData";
         }
         else
         {
            _loc1_ = "mainBar.TopToolsBar.funnyBtn.tipDataNew";
         }
         titleText = LanguageMgr.GetTranslation(_loc1_);
         _back = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.back");
         _leftBack = ComponentFactory.Instance.creatBitmap("asset.funny.leftBack");
         _gap = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.gap");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.leftVBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.nextBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.pageText");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack");
         _pageSp = new Sprite();
         _pageSp.x = 37;
         _pageSp.y = 346;
         _selectedBtnGroup = new SelectedButtonGroup();
         _funnyRightView = new FunnyRightView();
         addToContent(_back);
         addToContent(_leftBack);
         addToContent(_funnyRightView);
         _funnyRightView.x = 200;
         _funnyRightView.y = 3;
         addToContent(_gap);
         addToContent(_leftVBox);
         addToContent(_pageSp);
         _pageSp.addChild(_preBtn);
         _pageSp.addChild(_nextBtn);
         _pageSp.addChild(_pageBack);
         _pageBack.x = 31;
         _pageBack.y = 1;
         _pageSp.addChild(_pageText);
         _pageText.text = "1/1";
         _pageSp.visible = _total > 0;
         initActivityBtn();
         handlerGroupBuy();
         _newYearActView = ComponentFactory.Instance.creatCustomObject("funny.newyearact.payView");
         addToContent(_newYearActView);
         showNewYearActView();
         _mountActView = ComponentFactory.Instance.creatCustomObject("funny.mountAct");
         addToContent(_mountActView);
         showMountActView();
      }
      
      private function handlerGroupBuy() : void
      {
         if(!_isGroupBuy)
         {
            return;
         }
         _leftVBox.y = 60;
         initGroupBuyBtn();
         if(_funnyRightView && _funnyRightView.parent)
         {
            _funnyRightView.parent.removeChild(_funnyRightView);
         }
         _groupBuyView = ComponentFactory.Instance.creatComponentByStylename("groupbuy.groupBuyView");
         addToContent(_groupBuyView);
         _groupBuyListBar = ComponentFactory.Instance.creatComponentByStylename("groupbuy.groupBuyListBar",[_groupBuyArr]);
         addToContent(_groupBuyListBar);
         setLeftVBoxPos();
      }
      
      private function initGroupBuyBtn() : void
      {
         _groupBuyBtn = ComponentFactory.Instance.creatComponentByStylename("groupbuy.btnGroupbuy");
         var _loc1_:FunnyData = new FunnyData();
         _loc1_.type = 1005;
         _loc1_.title = LanguageMgr.GetTranslation("funny.groupbuy.btngroupbuy");
         _groupBuyBtn.data = _loc1_;
         addToContent(_groupBuyBtn);
      }
      
      private function initActivityBtn() : void
      {
         _activityBtn = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.activityBtn");
         var _loc1_:FunnyData = new FunnyData();
         _loc1_.id = "ACTIVITY_CODE_ID";
         _loc1_.type = 1001;
         _loc1_.title = LanguageMgr.GetTranslation("mainBar.SmallMapBar.activityRewardBtnTipData");
         _activityBtn.data = _loc1_;
         addToContent(_activityBtn);
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FunnyLeftButton = null;
         _selectedBtnGroup.removeAllItem();
         _leftVBox.disposeAllChildren();
         _selectedBtnGroup.addSelectItem(_activityBtn);
         if(_groupBuyBtn && _current == 1)
         {
            _selectedBtnGroup.addSelectItem(_groupBuyBtn);
         }
         if(_current == 1)
         {
            _startNum = 0;
            _endNum = _num;
         }
         else
         {
            _startNum = _num + 6 * (_current - 2);
            _endNum = _startNum + 6;
         }
         _loc1_ = _startNum;
         while(_loc1_ < _endNum)
         {
            if(_loc1_ >= _showData.length)
            {
               break;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.leftSelectedBtn");
            _loc2_.data = _showData[_loc1_];
            _selectedBtnGroup.addSelectItem(_loc2_);
            _leftVBox.addChild(_loc2_);
            _loc1_++;
         }
         pageState();
      }
      
      private function pageState() : void
      {
         _pageText.text = _current + "/" + _total;
         _preBtn.enable = _current > 1;
         _nextBtn.enable = _current < _total;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler2);
         FunnyManager.instance.addEventListener("REFRESH_TEMP",__receiveTempHandler);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageHandler);
         }
         if(_groupBuyListBar)
         {
            _groupBuyListBar.addEventListener("click",clickGroupBuyListBar);
         }
      }
      
      protected function clickGroupBuyListBar(param1:MouseEvent) : void
      {
         _selectedBtnGroup.selectIndex = 1;
         showGroupbuyView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler2);
         FunnyManager.instance.removeEventListener("REFRESH_TEMP",__receiveTempHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageHandler);
         }
         if(_groupBuyListBar)
         {
            _groupBuyListBar.removeEventListener("click",clickGroupBuyListBar);
         }
      }
      
      private function __receiveTempHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __pageHandler(param1:MouseEvent) : void
      {
         if(param1)
         {
            switch(param1.currentTarget)
            {
               case _preBtn:
                  if(_current >= 2)
                  {
                     _current -= 1;
                  }
                  break;
               case _nextBtn:
                  if(_current < _total)
                  {
                     _current += 1;
                  }
            }
         }
         refreshView();
         if(_showData.length <= _startNum)
         {
            return;
         }
         _index = _selectedBtnGroup.selectIndex = 1;
         _funnyRightView.data = _showData[_startNum];
         FunnyManager.instance.selectedId = _showData[_startNum].id;
         if(_funnyRightView && !_funnyRightView.parent)
         {
            addToContent(_funnyRightView);
         }
         showNewYearActView();
         showMountActView();
         if(_isGroupBuy)
         {
            if(_current == 1)
            {
               showGroupbuyListBar();
               showGroupbuyView();
               setLeftVBoxPos();
            }
            else
            {
               hideGroupbuy();
               _leftVBox.y = 4;
            }
         }
         var _loc2_:FunnyData = FunnyManager.instance.selectedFunnyData;
         if(_loc2_ && _loc2_.type == 49)
         {
            NewYearSocketOutManager.sendGetProfilt(0);
            showPayActView();
            _newYearActView.refreshData();
         }
         else if(_newYearActView.parent)
         {
            if(_newYearActView && _newYearActView.parent)
            {
               _newYearActView.parent.removeChild(_newYearActView);
            }
         }
      }
      
      private function showNewYearActView() : void
      {
         var _loc1_:FunnyData = FunnyManager.instance.selectedFunnyData;
         if(_loc1_ && _loc1_.type == 49)
         {
            NewYearSocketOutManager.sendGetProfilt(0);
            showPayActView();
            _newYearActView.refreshData();
         }
         else if(_newYearActView.parent)
         {
            _newYearActView.parent.removeChild(_newYearActView);
         }
      }
      
      private function showMountActView() : void
      {
         var _loc1_:FunnyData = FunnyManager.instance.selectedFunnyData;
         if(_loc1_ && _loc1_.type == 62)
         {
            MountActSocketOutManager.sendGetMountActInfo();
            showMountView();
            _mountActView.initData();
         }
         else if(_mountActView.parent)
         {
            _mountActView.parent.removeChild(_mountActView);
         }
      }
      
      private function setLeftVBoxPos() : void
      {
         if(_groupBuyArr.length <= 2)
         {
            _leftVBox.y = 115;
         }
         else if(_groupBuyArr.length > 2 && _groupBuyArr.length <= 4)
         {
            _leftVBox.y = 172;
         }
         else if(_groupBuyArr.length > 4)
         {
            _leftVBox.y = 230;
         }
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         refreshView();
         _selectedBtnGroup.selectIndex = _index;
         __selectedHandler(null);
      }
      
      private function __refreshHandler2(param1:FunnyEvent) : void
      {
         initShowData();
         refreshView();
         _selectedBtnGroup.selectIndex = _index;
         __selectedHandler(null);
      }
      
      private function hideGroupbuy() : void
      {
         _groupBuyBtn.visible = false;
         if(_groupBuyListBar && _groupBuyListBar.parent != null)
         {
            _groupBuyListBar.parent.removeChild(_groupBuyListBar);
         }
         if(_funnyRightView && _funnyRightView.parent == null)
         {
            addToContent(_funnyRightView);
         }
         if(_groupBuyView && _groupBuyView.parent != null)
         {
            _groupBuyView.parent.removeChild(_groupBuyView);
         }
         if(_newYearActView && _newYearActView.parent != null)
         {
            _newYearActView.parent.removeChild(_newYearActView);
         }
         if(_mountActView && _mountActView.parent)
         {
            _mountActView.parent.removeChild(_mountActView);
         }
      }
      
      private function showGroupbuyListBar() : void
      {
         _groupBuyBtn.visible = true;
         if(_groupBuyListBar && _groupBuyListBar.parent == null)
         {
            addToContent(_groupBuyListBar);
         }
      }
      
      private function showGroupbuyView() : void
      {
         if(_funnyRightView && _funnyRightView.parent)
         {
            _funnyRightView.parent.removeChild(_funnyRightView);
         }
         if(_newYearActView && _newYearActView.parent)
         {
            _newYearActView.parent.removeChild(_newYearActView);
         }
         if(_mountActView && _mountActView.parent)
         {
            _mountActView.parent.removeChild(_mountActView);
         }
         if(_groupBuyView && _groupBuyView.parent == null)
         {
            addToContent(_groupBuyView);
         }
      }
      
      private function showPayActView() : void
      {
         if(_funnyRightView && _funnyRightView.parent)
         {
            _funnyRightView.parent.removeChild(_funnyRightView);
         }
         if(_groupBuyView && _groupBuyView.parent)
         {
            _groupBuyView.parent.removeChild(_groupBuyView);
         }
         if(_mountActView && _mountActView.parent)
         {
            _mountActView.parent.removeChild(_mountActView);
         }
         if(_newYearActView && _newYearActView.parent == null)
         {
            addToContent(_newYearActView);
         }
      }
      
      private function showMountView() : void
      {
         if(_funnyRightView && _funnyRightView.parent)
         {
            _funnyRightView.parent.removeChild(_funnyRightView);
         }
         if(_groupBuyView && _groupBuyView.parent)
         {
            _groupBuyView.parent.removeChild(_groupBuyView);
         }
         if(_newYearActView && _newYearActView.parent)
         {
            _newYearActView.parent.removeChild(_newYearActView);
         }
         if(_mountActView && _mountActView.parent == null)
         {
            addToContent(_mountActView);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc2_:FunnyLeftButton = _selectedBtnGroup.getSelectedItem() as FunnyLeftButton;
         if(!_loc2_)
         {
            return;
         }
         FunnyManager.instance.selectedId = _loc2_.data.id;
         _funnyRightView.data = _loc2_.data;
         _index = _selectedBtnGroup.selectIndex;
         if(_loc2_.data.type == 1005)
         {
            showGroupbuyView();
            return;
         }
         if(_loc2_.data.type == 49)
         {
            if(_newYearActView && _newYearActView.parent == null)
            {
               NewYearSocketOutManager.sendGetProfilt(0);
               addToContent(_newYearActView);
               _newYearActView.refreshData();
            }
            if(_groupBuyView && _groupBuyView.parent)
            {
               _groupBuyView.parent.removeChild(_groupBuyView);
            }
            if(_funnyRightView && _funnyRightView.parent)
            {
               _funnyRightView.parent.removeChild(_funnyRightView);
            }
            if(_mountActView && _mountActView.parent)
            {
               _mountActView.parent.removeChild(_mountActView);
            }
         }
         else if(_loc2_.data.type == 62)
         {
            if(_mountActView && _mountActView.parent == null)
            {
               MountActSocketOutManager.sendGetMountActInfo();
               addToContent(_mountActView);
               _mountActView.initData();
            }
            if(_groupBuyView && _groupBuyView.parent)
            {
               _groupBuyView.parent.removeChild(_groupBuyView);
            }
            if(_newYearActView && _newYearActView.parent)
            {
               _newYearActView.parent.removeChild(_newYearActView);
            }
            if(_funnyRightView && _funnyRightView.parent)
            {
               _funnyRightView.parent.removeChild(_funnyRightView);
            }
         }
         else
         {
            if(_funnyRightView && _funnyRightView.parent == null)
            {
               addToContent(_funnyRightView);
            }
            if(_groupBuyView && _groupBuyView.parent)
            {
               _groupBuyView.parent.removeChild(_groupBuyView);
            }
            if(_mountActView && _mountActView.parent)
            {
               _mountActView.parent.removeChild(_mountActView);
            }
            if(_newYearActView && _newYearActView.parent)
            {
               _newYearActView.parent.removeChild(_newYearActView);
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _showData = null;
         _pageSp = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_leftBack);
         _leftBack = null;
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         ObjectUtils.disposeObject(_leftVBox);
         _leftVBox = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         ObjectUtils.disposeObject(_funnyRightView);
         _funnyRightView = null;
         ObjectUtils.disposeObject(_activityBtn);
         _activityBtn = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         if(_groupBuyView)
         {
            ObjectUtils.disposeObject(_groupBuyView);
            _groupBuyView = null;
         }
         if(_groupBuyListBar)
         {
            ObjectUtils.disposeObject(_groupBuyListBar);
            _groupBuyListBar = null;
         }
         if(_groupBuyBtn)
         {
            ObjectUtils.disposeObject(_groupBuyBtn);
            _groupBuyBtn = null;
         }
         if(_newYearActView)
         {
            ObjectUtils.disposeObject(_newYearActView);
            _newYearActView = null;
         }
         if(_mountActView)
         {
            ObjectUtils.disposeObject(_mountActView);
            _mountActView = null;
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         if(parent)
         {
            parent.removeChild(this);
         }
         FunnyManager.instance.model.canShine = true;
      }
   }
}

