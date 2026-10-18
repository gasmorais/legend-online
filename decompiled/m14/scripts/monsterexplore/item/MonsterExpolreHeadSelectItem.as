package monsterexplore.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class MonsterExpolreHeadSelectItem extends Component
   {
      
      private var _back:Image;
      
      private var _headIcon:BaseIconView;
      
      private var _level:FilterFrameText;
      
      private var _data:MonsterInfo;
      
      public function MonsterExpolreHeadSelectItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterExpolreHeadSelectItem.headBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("MonsterExpolreHeadSelectItem.levelTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("MonsterExpolreHeadSelectItem.headIcon");
         addChild(_back);
         addChild(_headIcon);
         addChild(_level);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemSelectHandler);
      }
      
      private function __itemSelectHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("EXPLORE_HEAD_SELECT",data);
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _headIcon.icon = IconFactory.getCommonIconPath(data.tempInfo.Icon);
            _headIcon.tipData = _data;
            _level.text = LanguageMgr.GetTranslation("public.level2",_data.grade);
         }
         else
         {
            _headIcon.icon = null;
            _headIcon.tipData = null;
            _level.text = "";
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         _data = null;
         super.dispose();
      }
   }
}

