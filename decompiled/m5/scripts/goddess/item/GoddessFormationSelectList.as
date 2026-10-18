package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessFormationInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessFormationSelectList extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vbox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _pos:int;
      
      private var _showEmpty:Boolean;
      
      private var _info:GoddessFormationInfo;
      
      public function GoddessFormationSelectList(param1:GoddessFormationInfo)
      {
         super();
         _info = param1;
         _showEmpty = _info.template ? true : false;
         initView();
         initEvent();
         initListInfo();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.checkmenuBg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.checkVbox");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("goddess.formation.ScrollPanel");
         addChild(_bg);
         addChild(_scrolPanel);
         _bg.width = 88;
         _bg.height = 195;
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vbox,true);
         _scrolPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
      }
      
      private function initListInfo() : void
      {
         var _loc2_:GoddessFormationSelectListItem = null;
         var _loc4_:GoddessInfo = null;
         var _loc3_:int = 0;
         if(_showEmpty)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("goddess.GoddessFormationSelectListItem");
            _loc2_.template = null;
            _vbox.addChild(_loc2_);
            _loc2_.addEventListener("click",__onClickHander);
         }
         var _loc1_:Array = model.sortInfos;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_] as GoddessInfo;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("goddess.GoddessFormationSelectListItem");
            _loc2_.formationInfo = _info;
            _loc2_.template = _loc4_.tempInfo;
            _loc2_.isActive = _loc4_.isActive;
            _vbox.addChild(_loc2_);
            _loc2_.addEventListener("click",__onClickHander);
            _loc3_++;
         }
         _scrolPanel.invalidateViewport();
      }
      
      private function __onClickHander(param1:MouseEvent) : void
      {
         var _loc2_:GoddessFormationSelectListItem = param1.currentTarget as GoddessFormationSelectListItem;
         if(!_loc2_)
         {
            return;
         }
         if(!_loc2_.template)
         {
            GodDessManager.instance.requestFormationSet(GodDessManager.instance.model.selectedArrayIndex,0);
         }
         else if(!_loc2_.isActive)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.array.text14"));
         }
         else
         {
            GodDessManager.instance.requestFormationSet(GodDessManager.instance.model.selectedArrayIndex,_loc2_.template.TemplateId);
         }
         dispose();
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GoddessFormationSelectListItem = null;
         if(_vbox)
         {
            _loc2_ = 0;
            while(_loc2_ < _vbox.numChildren)
            {
               _loc1_ = _vbox.getChildAt(_loc2_) as GoddessFormationSelectListItem;
               _loc1_.removeEventListener("click",__onClickHander);
               _loc2_ += 1;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

