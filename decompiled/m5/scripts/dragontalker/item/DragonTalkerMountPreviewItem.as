package dragontalker.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import org.bytearray.display.ScaleBitmap;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerMountPreviewItem extends Component
   {
      
      private var _back:Image;
      
      private var _overBg:Bitmap;
      
      private var _canvas:ScaleBitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _selectBtn:IconButton;
      
      private var _data:DragonTalkerFightMountTempInfo;
      
      public function DragonTalkerMountPreviewItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerMountPreviewItem.back");
         _overBg = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerBattle.selectOver");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerMountPreviewItem.nameText");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerMountPreviewItem.selectBtn");
         _canvas = new ScaleBitmap(new BitmapData(1,1,true,0));
         addChild(_back);
         addChild(_overBg);
         _overBg.visible = false;
         addChild(_canvas);
         addChild(_nameText);
         addChild(_selectBtn);
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",__clickSelectHandler);
         addEventListener("mouseOver",__onOverHandler);
         addEventListener("mouseOut",__onOutHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__clickSelectHandler);
         }
         removeEventListener("mouseOver",__onOverHandler);
         removeEventListener("mouseOut",__onOutHandler);
      }
      
      private function __clickSelectHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         DragonTalkerManager.instance.sendSelectFightMountReq(data.MountTempId);
         MsgMan.notifyObserver("CLOSE_PREVIEW_FRAME");
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            _overBg.visible = true;
         }
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      public function get data() : DragonTalkerFightMountTempInfo
      {
         return _data;
      }
      
      public function set data(param1:DragonTalkerFightMountTempInfo) : void
      {
         var _loc2_:String = null;
         clear();
         _data = param1;
         if(_data)
         {
            _selectBtn.visible = true;
            _nameText.text = data.TemplateName;
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _loc2_ = MountAvatarPathHelper.getBattleBesatPath(data.AvatarPath);
            LoaderManagerII.instance.load(_loc2_,2,4,__onLoaded);
            if(_data.MountTempId == model.selectBattleBeastId)
            {
               _selectBtn.enable = false;
               _selectBtn.iconStyle = "asset.DragonTalkerBattle.hasSelectBg";
               _selectBtn.iconInnerRectString = "4,69,0,34,13";
            }
            else
            {
               _selectBtn.enable = model.battleBeastGrade >= data.Grade;
               _selectBtn.iconStyle = "asset.DragonTalker.resource.battlebeast.ppj01o";
               _selectBtn.iconInnerRectString = "12,58,0,34,13";
            }
            if(model.battleBeastGrade >= data.Grade)
            {
               this.filters = [];
               this.tipData = null;
            }
            else
            {
               this.filters = [UIFilter.getGrayFilter()];
               this.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",data.Grade);
            }
         }
      }
      
      private function clear() : void
      {
         _nameText.text = "";
         _canvas.bitmapData.dispose();
         _overBg.visible = false;
         _selectBtn.visible = false;
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Rectangle = null;
         if(isDie || !data)
         {
            return;
         }
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            _loc4_.gotoAndStop(_loc4_.totalFrames - 1);
            _loc5_ = new BitmapData(500,500,true,0);
            _loc6_ = new Matrix();
            _loc6_.ty = 50;
            _loc5_.draw(_loc4_,_loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,false);
            _canvas.bitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _canvas.bitmapData.copyPixels(_loc5_,_loc3_,new Point(),null,null,true);
            _canvas.width = _loc3_.width * 0.4;
            _canvas.height = _loc3_.height * 0.4;
            _loc5_.dispose();
            _canvas.x = int((190 - _canvas.width) / 2);
            _canvas.y = 40;
         }
         _loc4_ = null;
      }
      
      public function get rect() : Rectangle
      {
         return new Rectangle(0,0,177,222);
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_canvas);
         _canvas = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         super.dispose();
      }
   }
}

