package buildings.politics.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.BuildingEvent;
   import flash.display.Sprite;
   import mvc.module.buildings.FieldData;
   import yishi.manager.BuildingManager;
   import yishi.utils.SimpleDictionary;
   
   public class PoliticsFieldView extends Sprite implements Disposeable
   {
      
      private var _fieldTitleItem:FildTitleItem;
      
      private var _contain:Sprite;
      
      private var _defaltVBox:VBox;
      
      private var _contentVBox:VBox;
      
      private var _scrollpanel:ScrollPanel;
      
      private var _data:XML;
      
      private var CAPACITY:int = 4;
      
      public function PoliticsFieldView()
      {
         super();
         init();
         initView();
         initEvent();
         __dataUpdateHandler(null);
      }
      
      private function init() : void
      {
         _defaltVBox = new VBox();
         _defaltVBox.spacing = -2;
         _contain = new Sprite();
         _contentVBox = new VBox();
         _contentVBox.spacing = -2;
         _contain.addChild(_defaltVBox);
         _fieldTitleItem = ComponentFactory.Instance.creatCustomObject("politics.FieldTitleItem");
         addChild(_fieldTitleItem);
         _scrollpanel = ComponentFactory.Instance.creatComponentByStylename("politics.ScrollPanel");
         _scrollpanel.setView(_contain);
         addChild(_scrollpanel);
      }
      
      private function initView() : void
      {
         var _loc2_:FieldItem = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY)
         {
            _loc2_ = new FieldItem();
            _defaltVBox.addChild(_loc2_);
            _loc1_++;
         }
         _scrollpanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         BuildingManager.instance.addEventListener("U_SECURITY_INFO_UPDATE",__dataUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         BuildingManager.instance.removeEventListener("U_SECURITY_INFO_UPDATE",__dataUpdateHandler);
      }
      
      private function __dataUpdateHandler(param1:BuildingEvent) : void
      {
         refreshView(BuildingManager.instance.model.fieldDic);
      }
      
      private function refreshView(param1:SimpleDictionary) : void
      {
         var _loc6_:FieldItem = null;
         var _loc5_:int = 0;
         var _loc7_:FieldData = null;
         clean();
         var _loc4_:int = 0;
         var _loc2_:Array = param1.getList();
         _loc2_.sort(sortOnTime);
         var _loc3_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = _loc2_[_loc5_] as FieldData;
            if(_loc7_.refreshTime > 0)
            {
               if(_loc4_ < _defaltVBox.numChildren)
               {
                  _loc6_ = _defaltVBox.getChildAt(_loc4_) as FieldItem;
                  _loc6_.data = _loc7_;
               }
               else
               {
                  _loc6_ = new FieldItem();
                  _loc6_.data = _loc7_;
                  _contentVBox.addChild(_loc6_);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         _contentVBox.y = _defaltVBox.y + _defaltVBox.height;
         _contain.addChild(_contentVBox);
         _scrollpanel.invalidateViewport();
      }
      
      private function sortOnTime(param1:FieldData, param2:FieldData) : int
      {
         var _loc3_:Number = Number(param1.refreshTime);
         var _loc4_:Number = Number(param2.refreshTime);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function clean() : void
      {
         var _loc2_:FieldItem = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CAPACITY)
         {
            _loc2_ = _defaltVBox.getChildAt(_loc1_) as FieldItem;
            _loc2_.data = null;
            _loc1_++;
         }
         _contentVBox.disposeAllChildren();
         _contentVBox.refreshChildPos();
         _scrollpanel.invalidateViewport();
      }
      
      public function set data(param1:XML) : void
      {
         _data = param1 as XML;
         refreshView(_data..wildLand..building);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _scrollpanel = null;
         _data = null;
         _contentVBox = null;
         _fieldTitleItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

