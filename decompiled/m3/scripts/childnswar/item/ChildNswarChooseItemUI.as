package childnswar.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class ChildNswarChooseItemUI extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _childData:ChildData;
      
      private var _posTxt:FilterFrameText;
      
      public function ChildNswarChooseItemUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.childnswar.team.Itembg");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritItem.childIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.nameText");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritItem.fightText");
         _posTxt = ComponentFactory.Instance.creatComponentByStylename("childnswar.choosePosTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_fightTxt);
         addChild(_posTxt);
      }
      
      public function set childData(param1:ChildData) : void
      {
         var _loc2_:ChildTempInfo = null;
         _childData = param1;
         if(_childData)
         {
            this.buttonMode = true;
            _loc2_ = _childData.childTempInfo;
            _nameTxt.text = _loc2_.JobName;
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            _fightTxt.htmlText = LanguageMgr.GetTranslation("ChildNursingSpiritItem.fightText.text",_childData.fightValue);
            initEvent();
         }
      }
      
      public function get childData() : ChildData
      {
         return _childData;
      }
      
      public function updatePosView(param1:int) : void
      {
         if(param1 < 0)
         {
            _posTxt.text = "";
         }
         else
         {
            _posTxt.text = LanguageMgr.GetTranslation("childnswar.team.pos" + param1);
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseDown",clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_childData)
         {
            NotificationManager.instance.sendNotification("ChildNswar.Event.ItemClick",_childData);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_posTxt);
         _posTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _childData = null;
      }
   }
}

