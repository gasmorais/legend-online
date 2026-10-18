package consortia.view.myConsortia.contribution
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaUserInfo;
   import yishi.manager.FrameControllerManager;
   
   public class ContributeItemList extends Sprite implements Disposeable
   {
      
      private var _data:ConsortiaModel;
      
      private var _infosItemList:Vector.<ConsortiaContributionItem>;
      
      private var _pageNum:int;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _pageBg:Image;
      
      private var _todayContributeBtn:SelectedButton;
      
      private var _historyContributeBtn:SelectedButton;
      
      private var _tapButtonGroup:SelectedButtonGroup;
      
      public function ContributeItemList()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _todayContributeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TodayContributeBtn");
         _historyContributeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.HistoryContributeBtn");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameNextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFramepageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFramePageTextStyle");
         _tapButtonGroup = new SelectedButtonGroup();
         _tapButtonGroup.addSelectItem(_todayContributeBtn);
         _tapButtonGroup.addSelectItem(_historyContributeBtn);
         _data = FrameControllerManager.instance.consortiaController.model;
         _pageNum = 8;
         _infosItemList = new Vector.<ConsortiaContributionItem>();
         addChild(_todayContributeBtn);
         addChild(_historyContributeBtn);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         _pageTxt.width = 64;
         _buttonGroup = new SelectedButtonGroup();
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _prePageBtn = null;
         _nextPageBtn = null;
         _todayContributeBtn = null;
         _historyContributeBtn = null;
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("UPDA_CONSORTIA_CONTRIBUTE_INFO",__onContributeInfoUpdata);
         _data.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         _data.addEventListener("ON_CONSORTIA_CONTRIBUTE_SUCCEED",__onContributeSucceedHandler);
         _data.addEventListener("UPDE_CONTRIBUTION_SEARCH_PAGE",__refreshPage);
         _prePageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
         _todayContributeBtn.addEventListener("click",__tabBtnHandler);
         _historyContributeBtn.addEventListener("click",__tabBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _data.removeEventListener("UPDA_CONSORTIA_CONTRIBUTE_INFO",__onContributeInfoUpdata);
         _data.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         _data.removeEventListener("ON_CONSORTIA_CONTRIBUTE_SUCCEED",__onContributeSucceedHandler);
         _data.removeEventListener("UPDE_CONTRIBUTION_SEARCH_PAGE",__refreshPage);
         _prePageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _todayContributeBtn.removeEventListener("click",__tabBtnHandler);
         _historyContributeBtn.removeEventListener("click",__tabBtnHandler);
      }
      
      private function initData() : void
      {
         setItemList();
         __refreshPage(null);
         __onContributeInfoUpdata(null);
         _todayContributeBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function __refreshPage(param1:ConsortiaEvent) : void
      {
         _pageTxt.text = _data.contributeListCurrentPage + "/" + _data.contributeListTotalPage;
         _prePageBtn.enable = _data.contributeListCurrentPage != 1;
         _nextPageBtn.enable = _data.contributeListCurrentPage != _data.contributeListTotalPage;
      }
      
      private function setItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaContributionItem = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ConsortiaContributionItem();
            _loc1_.y = _loc2_ * 32 + 41;
            _buttonGroup.addSelectItem(_loc1_);
            addChild(_loc1_);
            _infosItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __onContributeSucceedHandler(param1:ConsortiaEvent) : void
      {
         FrameControllerManager.instance.consortiaController.sendGetConsortiaOffer();
      }
      
      private function __onContributeInfoUpdata(param1:ConsortiaEvent) : void
      {
         refreshList();
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         FrameControllerManager.instance.consortiaController.sendGetConsortiaOffer();
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.contributeSearchPageHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function __tabBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.getConsortiaOffer(param1.currentTarget == _historyContributeBtn);
      }
      
      private function refreshList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:ConsortiaUserInfo = null;
         _buttonGroup.selectIndex = -1;
         var _loc1_:Array = _data.consortiaContributionList;
         var _loc3_:int = 8;
         _loc4_ = 0;
         while(_loc4_ < _infosItemList.length)
         {
            _loc2_ = _loc4_ < _infosItemList.length ? ConsortiaUserInfo(_loc1_[_loc4_]) : null;
            if(_loc2_)
            {
               _infosItemList[_loc4_].rankingTxt.text = _loc4_ + 1 + (_data.contributeListCurrentPage - 1) * _pageNum + "";
            }
            _infosItemList[_loc4_].setdata(_loc2_,_data.isHistory);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

