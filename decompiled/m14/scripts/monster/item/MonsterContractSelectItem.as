package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class MonsterContractSelectItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _enterWarImage:Image;
      
      private var _exploreWarImage:Image;
      
      private var _nameText:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _starHbox:HBox;
      
      private var _data:MonsterInfo;
      
      private var preStar:int;
      
      public function MonsterContractSelectItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.MonsterContractSelectItem.headBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectItem.levelTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("MonsterContractSelectItem.headIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectItem.nameText");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectItem.starHbox");
         _enterWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectItem.enterWarImage");
         _exploreWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectItem.exploreWarImage");
         addChild(_back);
         addChild(_headIcon);
         addChild(_enterWarImage);
         addChild(_exploreWarImage);
         addChild(_nameText);
         addChild(_level);
         addChild(_starHbox);
         _back.visible = false;
         _enterWarImage.visible = false;
         _exploreWarImage.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemSelectHandler);
         this.addEventListener("mouseOver",__onOverHandler);
         this.addEventListener("mouseOut",__onOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemSelectHandler);
         this.removeEventListener("mouseOver",__onOverHandler);
         this.removeEventListener("mouseOut",__onOutHandler);
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         _back.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _back.visible = false;
      }
      
      private function __itemSelectHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("CONTRACT_ITEM_SELECT",data);
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         _data = param1;
         if(_data)
         {
            _enterWarImage.visible = data.enterWar;
            _exploreWarImage.visible = model.exploreMonsterIds.indexOf(data.monsterId) != -1;
            if(_enterWarImage.visible && Boolean(_exploreWarImage.visible))
            {
               _exploreWarImage.x = 15;
            }
            else
            {
               _exploreWarImage.x = 28;
            }
            _headIcon.icon = IconFactory.getCommonIconPath(data.tempInfo.Icon);
            _headIcon.tipData = _data;
            _nameText.text = data.tempInfo.Name;
            _level.text = LanguageMgr.GetTranslation("public.level2",_data.grade);
            if(preStar != data.star)
            {
               _starHbox.removeAllChild();
               _loc3_ = 0;
               while(_loc3_ < data.star)
               {
                  _loc2_ = ComponentFactory.Instance.creatBitmap("asset.MonsterPropView.starBitmap");
                  _starHbox.addChild(_loc2_);
                  _loc3_++;
               }
            }
            preStar = data.star;
         }
         else
         {
            _headIcon.icon = null;
            _headIcon.tipData = null;
            _level.text = "";
            _nameText.text = "";
            _enterWarImage.visible = false;
            _exploreWarImage.visible = false;
            preStar = -1;
            _starHbox.removeAllChild();
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         ObjectUtils.disposeObject(_enterWarImage);
         _enterWarImage = null;
         ObjectUtils.disposeObject(_exploreWarImage);
         _exploreWarImage = null;
         _data = null;
         super.dispose();
      }
   }
}

