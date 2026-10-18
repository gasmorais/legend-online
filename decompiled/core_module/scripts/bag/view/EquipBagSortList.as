package bag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.manager.NotificationManager;
   
   public class EquipBagSortList extends Sprite implements Disposeable
   {
      
      private var _bg:DisplayObject;
      
      private var _sortByType:int = 0;
      
      private var _btnDic:Dictionary;
      
      public function EquipBagSortList()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _btnDic = new Dictionary();
         _bg = ComponentFactory.Instance.creat("core.commonTipBg");
         _bg.width = 110;
         _bg.height = 97;
         addChild(_bg);
         _btnDic[1] = ComponentFactory.Instance.creatComponentByStylename("army.PanelFashionSelectBtn");
         (_btnDic[1] as TextButton).text = LanguageMgr.GetTranslation("bag.view.EquipBagSortList.Fashion");
         _btnDic[2] = ComponentFactory.Instance.creatComponentByStylename("army.PanelPropSelectBtn");
         (_btnDic[2] as TextButton).text = LanguageMgr.GetTranslation("bag.view.EquipBagSortList.Prop");
         _btnDic[3] = ComponentFactory.Instance.creatComponentByStylename("army.PanelEquipSelectBtn");
         (_btnDic[3] as TextButton).text = LanguageMgr.GetTranslation("bag.view.EquipBagSortList.Equip");
         _btnDic[4] = ComponentFactory.Instance.creatComponentByStylename("army.PanelJewelSelectBtn");
         (_btnDic[4] as TextButton).text = LanguageMgr.GetTranslation("bag.view.EquipBagSortList.Jewel");
         for each(var _loc1_:TextButton in _btnDic)
         {
            addChild(_loc1_);
         }
      }
      
      private function initEvents() : void
      {
         for each(var _loc1_:TextButton in _btnDic)
         {
            _loc1_.addEventListener("click",__sortBtnClick);
         }
      }
      
      private function removeEvents() : void
      {
         for each(var _loc1_:TextButton in _btnDic)
         {
            _loc1_.removeEventListener("click",__sortBtnClick);
         }
      }
      
      private function __sortBtnClick(param1:MouseEvent) : void
      {
         for(var _loc2_:String in _btnDic)
         {
            if(_btnDic[_loc2_] == param1.currentTarget)
            {
               _sortByType = int(_loc2_);
               break;
            }
         }
         NotificationManager.instance.sendNotification("BAG_SORT_SELECT",_sortByType);
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
      }
   }
}

