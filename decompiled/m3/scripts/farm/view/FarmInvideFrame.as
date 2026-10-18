package farm.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FriendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmInvideFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _invideTxtBg:Bitmap;
      
      private var _invideTxtImg:Bitmap;
      
      private var _itemBox:VBox;
      
      private var _list:Array;
      
      private var _pageText:FilterFrameText;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBack:Bitmap;
      
      private var _pageCount:int;
      
      private var _pageIndex:int = 1;
      
      private var countByPage:int = 5;
      
      private var _allOnline:Array;
      
      private var _okBtn:TextButton;
      
      private var _noOnlineFirendTxt:FilterFrameText;
      
      public function FarmInvideFrame()
      {
         super();
         initView();
         initData();
         addEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FarmInvideItem = null;
         titleText = LanguageMgr.GetTranslation("farm.FarmInvideFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.invide.InvideBg");
         _invideTxtBg = ComponentFactory.Instance.creatBitmap("asset.farm.invide.InvideTxtBg");
         _invideTxtImg = ComponentFactory.Instance.creatBitmap("asset.farm.invide.InvideTxt");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("farm.invide.itemExchangeVbox");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack2");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ListPageText");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ListFirstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ListLastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ListPreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ListNextBtn");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.okBtn");
         _okBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _noOnlineFirendTxt = ComponentFactory.Instance.creatComponentByStylename("farm.mount.noonlinefirendTxt");
         _noOnlineFirendTxt.text = LanguageMgr.GetTranslation("farm.invideFarme.noonlineFirend");
         addToContent(_bg);
         addToContent(_invideTxtBg);
         addToContent(_invideTxtImg);
         addToContent(_itemBox);
         _pageBack.x = 135;
         _pageBack.y = 229;
         addToContent(_pageBack);
         addToContent(_pageText);
         addToContent(_firstBtn);
         addToContent(_lastBtn);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_okBtn);
         addToContent(_noOnlineFirendTxt);
         _list = [];
         _loc2_ = 0;
         while(_loc2_ < countByPage)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("farm.FarmInvideItem");
            _loc1_.visible = false;
            _itemBox.addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         var _loc3_:ThaneInfo = null;
         _allOnline = [];
         var _loc2_:Array = FriendManager.getInstance().friendListByArray;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc1_];
            if(_loc3_.isOnline && _loc3_.grades >= 12)
            {
               _allOnline.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc4_:int = 0;
         _noOnlineFirendTxt.visible = true;
         _pageCount = Math.ceil(_allOnline.length / 5);
         var _loc3_:int = -1;
         var _loc1_:int = (_pageIndex - 1) * countByPage;
         var _loc2_:int = _loc1_ + countByPage;
         _loc4_ = _loc1_;
         while(_loc4_ < _loc2_)
         {
            _loc3_++;
            _list[_loc3_].visible = false;
            _list[_loc3_].data = null;
            if(_loc4_ < _allOnline.length)
            {
               _list[_loc3_].visible = true;
               _list[_loc3_].selected = true;
               _list[_loc3_].data = _allOnline[_loc4_];
               if(_allOnline[_loc4_] != null)
               {
                  _noOnlineFirendTxt.visible = false;
               }
            }
            _loc4_++;
         }
         _pageText.text = _pageIndex + "/" + _pageCount;
         _firstBtn.enable = _lastBtn.enable = _preBtn.enable = _nextBtn.enable = false;
         if(_pageIndex > 1)
         {
            _firstBtn.enable = _preBtn.enable = true;
         }
         if(_pageCount > 1 && _pageIndex != _pageCount)
         {
            _lastBtn.enable = _nextBtn.enable = true;
         }
         if(_allOnline.length <= 0)
         {
            _firstBtn.enable = _lastBtn.enable = _preBtn.enable = _nextBtn.enable = false;
            _pageText.text = "0/1";
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_frameResponse);
         _firstBtn.addEventListener("click",onFirstBtnClick);
         _lastBtn.addEventListener("click",onLastBtnClick);
         _preBtn.addEventListener("click",onPreBtnClick);
         _nextBtn.addEventListener("click",onNextBtnClick);
         _okBtn.addEventListener("click",onOkBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         _firstBtn.removeEventListener("click",onFirstBtnClick);
         _lastBtn.removeEventListener("click",onLastBtnClick);
         _preBtn.removeEventListener("click",onPreBtnClick);
         _nextBtn.removeEventListener("click",onNextBtnClick);
         _okBtn.removeEventListener("click",onOkBtnClick);
      }
      
      private function onOkBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(_list == null)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc5_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _list.length)
         {
            if(_list[_loc4_].data != null && _list[_loc4_].selected)
            {
               _loc2_.push(ThaneInfo(_list[_loc4_].data).userId);
               _list[_loc4_].invide();
            }
            _loc4_++;
         }
         if(_list[0].data != null)
         {
            _loc5_ = true;
         }
         if(_loc2_.length == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("farm.invideFarme.noonlineFirend");
            if(_loc5_)
            {
               _loc3_ = LanguageMgr.GetTranslation("farm.invideFarme.noonSelectedFirend");
            }
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         FarmManager.instance.invideFirends(_loc2_);
      }
      
      private function onFirstBtnClick(param1:MouseEvent) : void
      {
         _pageIndex = 1;
         updateView();
      }
      
      private function onLastBtnClick(param1:MouseEvent) : void
      {
         _pageIndex = _pageCount;
         updateView();
      }
      
      private function onPreBtnClick(param1:MouseEvent) : void
      {
         _pageIndex -= 1;
         updateView();
      }
      
      private function onNextBtnClick(param1:MouseEvent) : void
      {
         _pageIndex += 1;
         updateView();
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_invideTxtBg);
         _invideTxtBg = null;
         ObjectUtils.disposeObject(_invideTxtImg);
         _invideTxtImg = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         _loc1_ = 0;
         while(_loc1_ < _list.length)
         {
            ObjectUtils.disposeObject(_list[_loc1_]);
            _list[_loc1_] = null;
            _loc1_++;
         }
         _list = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_lastBtn);
         _lastBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         _allOnline = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

