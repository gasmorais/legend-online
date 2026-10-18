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
   import yishi.view.community.BaseIconView;
   
   public class MonsterListItem extends Component
   {
      
      private var _gradeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      private var _selectBg:Image;
      
      private var _itemBack:Image;
      
      private var _starHbox:HBox;
      
      private var _lockImage:Image;
      
      private var _enterWarImage:Image;
      
      private var _exploreWarImage:Image;
      
      private var _data:MonsterInfo;
      
      private var preStar:int;
      
      public function MonsterListItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterListItem.gradeText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterListItem.nameText");
         _headIcon = ComponentFactory.Instance.creatCustomObject("Monster.MonsterListItem.headIcon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterListItem.selectBg");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterListItem.itemBack");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterListItem.starHbox");
         _lockImage = ComponentFactory.Instance.creatComponentByStylename("MonsterListItem.lockImage");
         _enterWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterListItem.enterWarImage");
         _exploreWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterListItem.exploreWarImage");
         addChild(_itemBack);
         addChild(_selectBg);
         _selectBg.visible = false;
         addChild(_headIcon);
         addChild(_nameText);
         addChild(_gradeText);
         addChild(_starHbox);
         _starHbox.mouseEnabled = false;
         addChild(_lockImage);
         _lockImage.visible = false;
         addChild(_enterWarImage);
         _enterWarImage.visible = false;
         addChild(_exploreWarImage);
         _exploreWarImage.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         model.selectMonster = data;
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
         if(data)
         {
            _enterWarImage.visible = data.enterWar;
            _exploreWarImage.visible = model.exploreMonsterIds.indexOf(data.monsterId) != -1;
            if(_enterWarImage.visible && Boolean(_exploreWarImage.visible))
            {
               _exploreWarImage.x = 20;
            }
            else
            {
               _exploreWarImage.x = 50;
            }
            _headIcon.icon = IconFactory.getCommonIconPath(data.tempInfo.Icon);
            _nameText.text = data.tempInfo.Name;
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",data.grade);
            _headIcon.tipData = data;
            _lockImage.visible = data.isLock;
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
            preStar = -1;
            _starHbox.removeAllChild();
            _headIcon.icon = null;
            _nameText.text = "";
            _gradeText.text = "";
            _selectBg.visible = false;
            _lockImage.visible = false;
            _enterWarImage.visible = false;
            _exploreWarImage.visible = false;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(!data)
         {
            return;
         }
         _selectBg.visible = param1;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_enterWarImage);
         _enterWarImage = null;
         ObjectUtils.disposeObject(_exploreWarImage);
         _exploreWarImage = null;
         super.dispose();
      }
   }
}

