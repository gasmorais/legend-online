package pveroomlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class PVEPlayerListItem extends SelectedButton implements IListCell
   {
      
      private var _data:ThaneInfo;
      
      private var _nameText:FilterFrameText;
      
      private var _vipNameText:GradientText;
      
      private var _levelText:FilterFrameText;
      
      private var _vipLevelText:GradientText;
      
      private var _line:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _nameTextStyle:String;
      
      private var _vipNameTextStyle:String;
      
      private var _levelTextStyle:String;
      
      private var _vipLevelTextStyle:String;
      
      private var _vipIcon:ScaleFrameImage;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public function PVEPlayerListItem()
      {
         super();
         _line = ComponentFactory.Instance.creatBitmap("asset.pveroomlist.PlayerSpliceLine");
         _icon = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.SexIcon");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.VocationIcon");
         _vocationIcon.visible = false;
      }
      
      public function set nameTextStyle(param1:String) : void
      {
         if(_nameTextStyle == param1)
         {
            return;
         }
         _nameTextStyle = param1;
         _nameText = ComponentFactory.Instance.creatComponentByStylename(_nameTextStyle);
      }
      
      public function get nameTextStyle() : String
      {
         return _nameTextStyle;
      }
      
      public function set vipNameTextStyle(param1:String) : void
      {
         if(_vipNameTextStyle == param1)
         {
            return;
         }
         _vipNameTextStyle = param1;
         _vipNameText = ComponentFactory.Instance.creatComponentByStylename(_vipNameTextStyle);
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _vipIcon.x = _vipNameText.x - _vipIcon.width;
         _vipIcon.y = _vipNameText.y + 2;
      }
      
      public function get vipNameTextStyle() : String
      {
         return _vipNameTextStyle;
      }
      
      public function set levelTextStyle(param1:String) : void
      {
         if(_levelTextStyle == param1)
         {
            return;
         }
         _levelTextStyle = param1;
         _levelText = ComponentFactory.Instance.creatComponentByStylename(_levelTextStyle);
      }
      
      public function get levelTextStyle() : String
      {
         return _levelTextStyle;
      }
      
      public function set vipLevelTextStyle(param1:String) : void
      {
         if(_vipLevelTextStyle == param1)
         {
            return;
         }
         _vipLevelTextStyle = param1;
         _vipLevelText = ComponentFactory.Instance.creatComponentByStylename(_vipLevelTextStyle);
      }
      
      public function get vipLevelTextStyle() : String
      {
         return _vipLevelTextStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_line)
         {
            addChild(_line);
         }
         if(_nameText)
         {
            addChild(_nameText);
         }
         if(_vipNameText)
         {
            addChild(_vipNameText);
         }
         if(_levelText)
         {
            addChild(_levelText);
         }
         if(_vipLevelText)
         {
            addChild(_vipLevelText);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_vipIcon)
         {
            addChild(_vipIcon);
         }
         if(_vocationIcon)
         {
            addChild(_vocationIcon);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as ThaneInfo;
         if(_icon)
         {
            _icon.visible = true;
         }
         if(_data.templateInfo.Sexs == 1)
         {
            if(_icon)
            {
               _icon.setFrame(1);
            }
         }
         else if(_icon)
         {
            _icon.setFrame(2);
         }
         if(_nameText)
         {
            _nameText.text = _data.nickName || "";
         }
         if(_vipNameText)
         {
            _vipNameText.text = _data.nickName || "";
         }
         if(_levelText)
         {
            _levelText.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
         }
         if(_vipLevelText)
         {
            _vipLevelText.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
         }
         updateStatus();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         updateStatus();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            this.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            this.tipData = null;
            _vocationIcon.visible = false;
         }
      }
      
      private function updateStatus() : void
      {
         if(!_data)
         {
            return;
         }
         if(_nameText)
         {
            _nameText.visible = false;
         }
         if(_vipNameText)
         {
            _vipNameText.visible = false;
         }
         if(_levelText)
         {
            _levelText.visible = false;
         }
         if(_vipLevelText)
         {
            _vipLevelText.visible = false;
         }
         if(_vipIcon)
         {
            _vipIcon.visible = false;
         }
         _data.vipType == 1 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
         if(_selected)
         {
            if(_nameText)
            {
               _nameText.visible = true;
               if(_data.IsVipAndNoExpirt)
               {
                  if(_vipNameText)
                  {
                     _vipNameText.visible = true;
                     _nameText.visible = false;
                  }
               }
               else
               {
                  _nameText.setFrame(1);
               }
            }
            if(_levelText)
            {
               _levelText.visible = true;
               if(_data.IsVipAndNoExpirt)
               {
                  if(_vipLevelText)
                  {
                     _vipLevelText.visible = true;
                     _levelText.visible = false;
                  }
               }
               else
               {
                  _levelText.setFrame(1);
               }
            }
            if(_vipIcon)
            {
               if(_data.IsVipAndNoExpirt)
               {
                  _vipIcon.visible = true;
               }
            }
         }
         else
         {
            if(_nameText)
            {
               if(!_data.IsVipAndNoExpirt)
               {
                  _nameText.visible = true;
               }
               _nameText.setFrame(1);
            }
            if(_vipNameText)
            {
               if(_data.IsVipAndNoExpirt)
               {
                  _vipNameText.visible = true;
                  _vipIcon.visible = true;
               }
            }
            if(_levelText)
            {
               if(!_data.IsVipAndNoExpirt)
               {
                  _levelText.visible = true;
               }
               _levelText.setFrame(1);
            }
            if(_vipLevelText && _vipIcon)
            {
               if(_data.IsVipAndNoExpirt)
               {
                  _vipLevelText.visible = true;
                  _vipIcon.visible = true;
               }
            }
         }
         refreshVocation();
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

