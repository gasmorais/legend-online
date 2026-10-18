package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardUserInfo;
   import mvc.module.outyard.OutyardCrystalModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardChangeView extends Sprite implements Disposeable
   {
      
      private var _roleBtn:BaseButton;
      
      private var _levelBtn:BaseButton;
      
      private var _stateBtn:BaseButton;
      
      private var _apBtn:BaseButton;
      
      private var _titlebarBg:MutipleImage;
      
      private var _border:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _memberTxt:FilterFrameText;
      
      private var _memberNumTxt:FilterFrameText;
      
      private var _itemList:Vector.<OutyardChangeItem>;
      
      private var _data:Object;
      
      private var _model:OutyardCrystalModel;
      
      private var _sortField:String = "fightingCapacity";
      
      private var _isReverse:Boolean = true;
      
      public function OutyardChangeView()
      {
         super();
         _model = OutyardManager.instance.crystalModel;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarTitlebarImg");
         _roleBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarRoleButton");
         _levelBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarLevelButton");
         _stateBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarStateButton");
         _apBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarAPButton");
         _border = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarLeftBg");
         _border.width = 440;
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarRightScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarLeftVbox");
         _memberTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarMemberText03");
         _memberNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.EnterWarMemberText04");
         _memberTxt.text = LanguageMgr.GetTranslation("gvg.view.ready.EnterWarFrame.inWar");
         _memberNumTxt.text = "";
         addChild(_border);
         addChild(_scrolPanel);
         addChild(_memberTxt);
         addChild(_memberNumTxt);
         addChild(_titlebarBg);
         addChild(_roleBtn);
         addChild(_levelBtn);
         addChild(_stateBtn);
         addChild(_apBtn);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox);
         _scrolPanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         _roleBtn.addEventListener("click",__onSortClick);
         _levelBtn.addEventListener("click",__onSortClick);
         _stateBtn.addEventListener("click",__onSortClick);
         _apBtn.addEventListener("click",__onSortClick);
         setListView();
      }
      
      private function removeEvent() : void
      {
         if(_roleBtn)
         {
            _roleBtn.removeEventListener("click",__onSortClick);
         }
         if(_levelBtn)
         {
            _levelBtn.removeEventListener("click",__onSortClick);
         }
         if(_stateBtn)
         {
            _stateBtn.removeEventListener("click",__onSortClick);
         }
         if(_apBtn)
         {
            _apBtn.removeEventListener("click",__onSortClick);
         }
      }
      
      private function __onSortClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _roleBtn:
               _sortField = "nickName";
               break;
            case _levelBtn:
               _sortField = "grades";
               break;
            case _stateBtn:
               _sortField = "inBattle";
               break;
            case _apBtn:
               _sortField = "fightingCapacity";
         }
         _isReverse = !_isReverse;
         setListView();
      }
      
      public function setListView() : void
      {
         var _loc2_:OutyardChangeItem = null;
         _vBox.beginChanges();
         clearList();
         var _loc1_:int = 0;
         if(!_itemList)
         {
            _itemList = new Vector.<OutyardChangeItem>();
         }
         var _loc3_:int = 0;
         var _loc4_:int = int(ConsortiaManager.instance.model.consortiaInfo.chairmanID);
         var _loc5_:Array = _model.getSortMemberList(_sortField,_isReverse);
         for each(var _loc6_:OutyardUserInfo in _loc5_)
         {
            _loc2_ = new OutyardChangeItem();
            _loc2_.info = _loc6_;
            _loc2_.index = _loc3_++;
            _itemList.push(_loc2_);
            _vBox.addChild(_loc2_);
            _loc1_++;
         }
         while(_loc3_ < 10)
         {
            _loc2_ = new OutyardChangeItem();
            _loc2_.info = null;
            _loc2_.index = _loc3_++;
            _itemList.push(_loc2_);
            _vBox.addChild(_loc2_);
         }
         _vBox.refreshChildPos();
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
         _loc1_ = Math.min(_loc1_,50);
         _memberNumTxt.text = _loc1_ + " / 50";
      }
      
      private function clearList() : void
      {
         for each(var _loc1_:OutyardChangeItem in _itemList)
         {
            _loc1_.dispose();
         }
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearList();
         _itemList = null;
         if(_roleBtn)
         {
            _roleBtn.dispose();
         }
         _roleBtn = null;
         if(_levelBtn)
         {
            _levelBtn.dispose();
         }
         _levelBtn = null;
         if(_stateBtn)
         {
            _stateBtn.dispose();
         }
         _stateBtn = null;
         if(_apBtn)
         {
            _apBtn.dispose();
         }
         _apBtn = null;
         if(_titlebarBg)
         {
            _titlebarBg.dispose();
         }
         _titlebarBg = null;
         if(_border)
         {
            _border.dispose();
         }
         _border = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_scrolPanel)
         {
            _scrolPanel.dispose();
         }
         _scrolPanel = null;
         if(_memberTxt)
         {
            _memberTxt.dispose();
         }
         _memberTxt = null;
         if(_memberNumTxt)
         {
            _memberNumTxt.dispose();
         }
         _memberNumTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

