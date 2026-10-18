package ancientartifact.view
{
   import ancientartifact.view.item.AncientArtifactItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.events.NotificationEvent;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   
   public class AncientArtifactList extends Component
   {
      
      private var _leftBottomBg:Image;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:DisplayObject;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodList:Array;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var _countGood:int = 0;
      
      private var _isFirst:Boolean = true;
      
      private var _selectItem:AncientArtifactItem;
      
      public function AncientArtifactList()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AncientArtifactItem = null;
         _leftBottomBg = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.leftBottomBg");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.NextPageBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.LastPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.pageNumBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.PageTextStyle1");
         addChild(_leftBottomBg);
         addChild(_preBtn);
         _preBtn.enable = false;
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         addChild(_pageTxt);
         _pageTxt.text = "1/1";
         _goodList = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new AncientArtifactItem();
            _loc1_.x = 5;
            _loc1_.y = 0 + _loc2_ * 92;
            addChild(_loc1_);
            _goodList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",_preHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextHandler);
         }
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
      }
      
      private function __itemClickHandler(param1:NotificationEvent) : void
      {
         setItemSelected();
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_isFirst)
         {
            _loc3_ = int(AncientArtifactManager.instance.getIsEquipIdx());
            _currentPage = 1 + int(_loc3_ / 4);
            _loc2_ = _loc3_ % 4;
            updateView();
            _goodList[_loc2_].dispatchEvent(new MouseEvent("click"));
            _isFirst = false;
         }
         else
         {
            updateView();
         }
      }
      
      public function selectDispatchEvent() : void
      {
         if(_selectItem)
         {
            _selectItem.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc1_:Array = AncientArtifactManager.instance.getArtifactTemplates();
         if(_loc1_.length % 4 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 4 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 4;
         }
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 4;
            }
            if(_loc1_.length > _loc2_)
            {
               _countGood = _countGood + 1;
               _goodList[_loc3_].info = _loc1_[_loc2_];
            }
            else
            {
               _goodList[_loc3_].info = null;
            }
            _loc3_++;
         }
         updatePageView();
         setItemSelected();
      }
      
      private function setItemSelected() : void
      {
         var _loc1_:AncientArtifactItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = int(AncientArtifactManager.instance.selectTempId);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = _goodList[_loc2_] as AncientArtifactItem;
            if(_loc3_ == _loc1_.info.TemplateId)
            {
               _loc1_.selected = true;
               _selectItem = _loc1_;
            }
            else
            {
               _loc1_.selected = false;
            }
            _loc2_++;
         }
      }
      
      private function updatePageView() : void
      {
         _pageTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_goodList);
         _goodList = null;
         ObjectUtils.disposeObject(_leftBottomBg);
         _leftBottomBg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         _selectItem = null;
         super.dispose();
      }
   }
}

