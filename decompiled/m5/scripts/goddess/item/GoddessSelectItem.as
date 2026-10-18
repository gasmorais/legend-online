package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseIconView;
   
   public class GoddessSelectItem extends Sprite
   {
      
      private var _lvTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _selectImg:Bitmap;
      
      private var _fightImg:Bitmap;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _dedicationLv:TextAddBitmap;
      
      private var _data:GoddessInfo;
      
      private var _gray:Array;
      
      public function GoddessSelectItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            selected = false;
            isFight = false;
            _nameTxt.visible = false;
            _lvTxt.visible = false;
            _icon.visible = false;
            this.filters = _gray;
            buttonMode = false;
            _profileImg.setFrame(1);
         }
         else
         {
            _nameTxt.visible = true;
            _lvTxt.visible = true;
            _icon.visible = true;
            buttonMode = true;
            _nameTxt.text = _data.tempInfo.TemplateName;
            level = _data.grade;
            quality = _data.advanceTempInfo.Quality;
            devote = _data.devote;
            _icon.icon = PathManager.getGoddessHeadIcon(_data.tempInfo.Pic);
            isFight = _data.isFight;
            selected = _data == model.selectInfo;
            if(_data.isActive)
            {
               this.filters = null;
            }
            else
            {
               this.filters = _gray;
            }
         }
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      public function set level(param1:int) : void
      {
         _lvTxt.text = LanguageMgr.GetTranslation("public.level2",param1);
      }
      
      public function set quality(param1:int) : void
      {
         _profileImg.setFrame(param1);
         _nameTxt.setFrame(param1);
         _lvTxt.setFrame(param1);
      }
      
      public function set devote(param1:int) : void
      {
         _dedicationLv.setText("+" + param1);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectImg.visible = param1;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         _fightImg.visible = param1;
      }
      
      public function get templeteID() : int
      {
         return 0;
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.profileImg");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.choose.LvTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.choose.NameTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.goddess.choose.roleIcon");
         _selectImg = ComponentFactory.Instance.creatBitmap("asset.goddess.choose.lightImg");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.goddess.choose.fightImg");
         _dedicationLv = ComponentFactory.Instance.creatCustomObject("ui.goddess.dedicationLv");
         addChild(_profileImg);
         addChild(_lvTxt);
         addChild(_nameTxt);
         addChild(_icon);
         addChild(_fightImg);
         addChild(_dedicationLv);
         addChild(_selectImg);
         _dedicationLv.initView("ui.goddess.dedicationLvTxt","asset.goddess.dedicationFt","right");
      }
      
      private function initEvent() : void
      {
         addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         GodDessManager.instance.model.selectInfo = _data;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_selectImg);
         _selectImg = null;
         ObjectUtils.disposeObject(_dedicationLv);
         _dedicationLv = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
         _data = null;
      }
   }
}

