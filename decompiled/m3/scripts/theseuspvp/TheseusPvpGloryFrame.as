package theseuspvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpSeasonInfo;
   import mvc.module.theseuspvp.TheseusPvpShowInfo;
   import mvc.module.theseuspvp.TheseusPvpUserInfo;
   import theseuspvp.item.TheseusPvpZanItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class TheseusPvpGloryFrame extends Frame
   {
      
      public var _gloryBg:Bitmap;
      
      public var _zan2:TheseusPvpZanItem;
      
      public var _zan1:TheseusPvpZanItem;
      
      public var _zan3:TheseusPvpZanItem;
      
      public var _gloryTimeBg:Bitmap;
      
      public var _gloryTitleBg:Bitmap;
      
      public var _gloryTitle:Bitmap;
      
      public var _gloryPreBtn:BaseButton;
      
      public var _gloryNextBtn:BaseButton;
      
      private var _bg:Scale9CornerImage;
      
      private var _timeT:GradientText;
      
      private var _listDic:SimpleDictionary = new SimpleDictionary();
      
      private var _keyList:Array = [];
      
      private var _currPage:int;
      
      private var _pageMax:int;
      
      public function TheseusPvpGloryFrame()
      {
         super();
         initView();
         initEvent();
         TheseusPvpManager.Instance.doSomething(6);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gridImage");
         _gloryBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.gloryBg");
         _zan2 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.zan2",[2]);
         _zan1 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.zan1",[1]);
         _zan3 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.zan3",[3]);
         _gloryTimeBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.gloryTimeBg");
         _gloryTitleBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.gloryTitleBg");
         _gloryTitle = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.gloryTitle");
         _gloryPreBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryPreBtn");
         _gloryNextBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryNextBtn");
         _timeT = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryTimT");
         addToContent(_bg);
         addToContent(_gloryBg);
         addToContent(_zan2);
         addToContent(_zan1);
         addToContent(_zan3);
         addToContent(_gloryTimeBg);
         addToContent(_gloryTitleBg);
         addToContent(_gloryTitle);
         addToContent(_gloryPreBtn);
         addToContent(_gloryNextBtn);
         addToContent(_timeT);
         _zan1.appelId = 140;
         _zan2.appelId = 141;
         _zan3.appelId = 142;
         listHandler();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _gloryPreBtn.addEventListener("click",__onPageHandler);
         _gloryNextBtn.addEventListener("click",__onPageHandler);
         NotificationManager.instance.addEventListener("theseusDoublepvpShowEvent",listHandler);
         NotificationManager.instance.addEventListener("theseuspvpUserInfoEvent",updateZanHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _gloryPreBtn.removeEventListener("click",__onPageHandler);
         _gloryNextBtn.removeEventListener("click",__onPageHandler);
         NotificationManager.instance.removeEventListener("theseusDoublepvpShowEvent",listHandler);
         NotificationManager.instance.removeEventListener("theseuspvpUserInfoEvent",updateZanHandler);
      }
      
      private function updateZanHandler(param1:Event = null) : void
      {
         var _loc2_:TheseusPvpUserInfo = TheseusPvpManager.Instance.model.selfUserInfo;
         var _loc4_:Array = _loc2_.likeInfo.split(",");
         var _loc3_:int = _pageMax > 1 ? _pageMax - 2 : _pageMax - 1;
         var _loc5_:int = int(_keyList[_loc3_]);
         _zan1.updateZanState(int(_loc4_[0]),_loc5_);
         _zan2.updateZanState(int(_loc4_[1]),_loc5_);
         _zan3.updateZanState(int(_loc4_[2]),_loc5_);
      }
      
      private function listHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         _listDic.clear();
         _keyList.length = 0;
         var _loc5_:Array = param1 != null ? param1.data as Array : [];
         for each(var _loc6_:TheseusPvpShowInfo in _loc5_)
         {
            _loc4_ = int(_loc6_.seasonId);
            _loc2_ = _listDic[_loc4_];
            if(!_loc2_)
            {
               _keyList.push(_loc4_);
               _loc2_ = [];
               _listDic.add(_loc4_,_loc2_);
            }
            _loc2_.push(_loc6_);
         }
         var _loc3_:TheseusPvpSeasonInfo = TheseusPvpManager.Instance.model.seasonTimeInfo;
         _loc4_ = int(_loc3_.seasonId);
         if(_keyList.indexOf(_loc4_) == -1)
         {
            _keyList.push(_loc4_);
         }
         _keyList.sort(16);
         _pageMax = _keyList.length;
         if(_pageMax > 1)
         {
            currPage = _pageMax - 2;
         }
         else
         {
            currPage = _pageMax - 1;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:TheseusPvpSeasonInfo = null;
         if(_pageMax < 0)
         {
            return;
         }
         var _loc3_:int = int(_keyList[_currPage]);
         var _loc4_:Array = _listDic[_loc3_];
         if(_loc4_ == null)
         {
            _loc1_ = TheseusPvpManager.Instance.model.seasonTimeInfo;
            _timeT.text = LanguageMgr.GetTranslation("theseuspvp.timeQuJian",_loc1_.startDate.substr(0,10),_loc1_.stopDate.substr(0,10));
            _loc4_ = [];
         }
         _loc4_.sortOn("rank",16);
         var _loc2_:TheseusPvpShowInfo = _loc4_[0];
         _zan1.data = _loc2_;
         if(_loc2_)
         {
            _timeT.text = LanguageMgr.GetTranslation("theseuspvp.timeQuJian",_loc2_.startDate.substr(0,10),_loc2_.stopDate.substr(0,10));
         }
         _loc2_ = _loc4_[1];
         _zan2.data = _loc2_;
         _loc2_ = _loc4_[2];
         _zan3.data = _loc2_;
         updateZanHandler();
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _gloryPreBtn)
         {
            currPage = _currPage - 1;
         }
         else
         {
            currPage = _currPage + 1;
         }
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
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gloryBg);
         _gloryBg = null;
         ObjectUtils.disposeObject(_zan2);
         _zan2 = null;
         ObjectUtils.disposeObject(_zan1);
         _zan1 = null;
         ObjectUtils.disposeObject(_zan3);
         _zan3 = null;
         ObjectUtils.disposeObject(_gloryTimeBg);
         _gloryTimeBg = null;
         ObjectUtils.disposeObject(_gloryTitleBg);
         _gloryTitleBg = null;
         ObjectUtils.disposeObject(_gloryTitle);
         _gloryTitle = null;
         ObjectUtils.disposeObject(_gloryPreBtn);
         _gloryPreBtn = null;
         ObjectUtils.disposeObject(_gloryNextBtn);
         _gloryNextBtn = null;
         ObjectUtils.disposeObject(_timeT);
         _timeT = null;
         super.dispose();
      }
      
      public function set currPage(param1:int) : void
      {
         _currPage = param1;
         if(_currPage <= 0)
         {
            _currPage = 0;
            _gloryPreBtn.enable = false;
         }
         else
         {
            _gloryPreBtn.enable = true;
         }
         if(_currPage >= _pageMax - 1)
         {
            _currPage = _pageMax - 1;
            _gloryNextBtn.enable = false;
         }
         else
         {
            _gloryNextBtn.enable = true;
         }
         refreshView();
      }
   }
}

