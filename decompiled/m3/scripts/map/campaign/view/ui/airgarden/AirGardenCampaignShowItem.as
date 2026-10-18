package map.campaign.view.ui.airgarden
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import managers.AirGardenManager;
   import map.internals.data.CampaignNode;
   import mvc.module.children.ChildData;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.pet.PetData;
   import org.bytearray.display.ScaleBitmap;
   import yishi.manager.PathManager;
   import yishi.utils.MountAvatarPathHelper;
   
   public class AirGardenCampaignShowItem extends Component implements IManualSize
   {
      
      private var _nameText:FilterFrameText;
      
      private var _back:Bitmap;
      
      private var _avatarImage:ScaleBitmap;
      
      private var _showBtn:IconButton;
      
      private var nodeInfo:CampaignNode;
      
      private var _data:Object;
      
      private var tempId:int;
      
      public function AirGardenCampaignShowItem(param1:CampaignNode)
      {
         super();
         nodeInfo = param1;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,221,243);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignShowItem.back");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignShowItem.nameText");
         _showBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignShowItem.showBtn");
         _avatarImage = new ScaleBitmap(new BitmapData(1,1,true,0));
         addChild(_back);
         addChild(_avatarImage);
         addChild(_nameText);
         addChild(_showBtn);
         this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _showBtn.addEventListener("click",__showBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_showBtn)
         {
            _showBtn.removeEventListener("click",__showBtnClickHandler);
         }
      }
      
      private function __showBtnClickHandler(param1:MouseEvent) : void
      {
         if(!nodeInfo || !data)
         {
            return;
         }
         AirGardenManager.instance.reqAirGardenBed(tempId,nodeInfo.nodeId);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(data)
         {
            _showBtn.visible = true;
            _loc2_ = "";
            if(data is PetData)
            {
               tempId = (data as PetData).petId;
               _nameText.text = (data as PetData).template.TemplateName;
               _loc2_ = PathManager.getPetMorphShowPath((data as PetData).template.PetAvatar);
            }
            else if(data is ChildData)
            {
               tempId = (data as ChildData).childId;
               _nameText.text = (data as ChildData).childTempInfo.JobName;
               _loc2_ = PathManager.getChildShowByJobAndGrade((data as ChildData).job,(data as ChildData).growthGrade);
            }
            else if(data is WildSoulInfo)
            {
               tempId = (data as WildSoulInfo).template.TemplateId;
               _nameText.text = (data as WildSoulInfo).template.TemplateName;
               _loc2_ = MountAvatarPathHelper.getUrl((data as WildSoulInfo).template.AvatarPath);
            }
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onAvatarLoaded);
            if(_loc2_ != "")
            {
               LoaderManagerII.instance.load(_loc2_,2,8,__onAvatarLoaded);
            }
         }
         else
         {
            _nameText.text = "";
            _showBtn.visible = false;
            _avatarImage.bitmapData.dispose();
         }
      }
      
      private function __onAvatarLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Rectangle = null;
         if(isDie || !_data)
         {
            return;
         }
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            if(data is PetData)
            {
               _loc4_.gotoAndStop(2);
            }
            else if(data is ChildData)
            {
               _loc4_.gotoAndStop(_loc4_.totalFrames - 1);
            }
            else if(data is WildSoulInfo)
            {
               _loc4_.gotoAndStop(2);
            }
            _loc5_ = new BitmapData(1000,1000,true,0);
            _loc6_ = new Matrix();
            _loc6_.ty = 100;
            _loc6_.tx = 120;
            _loc5_.draw(_loc4_,_loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,false);
            _avatarImage.bitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _avatarImage.bitmapData.copyPixels(_loc5_,_loc3_,new Point(),null,null,true);
            _avatarImage.width = _loc3_.width * 0.6;
            _avatarImage.height = _loc3_.height * 0.6;
            _loc5_.dispose();
            _avatarImage.x = int((221 - _avatarImage.width) / 2);
            _avatarImage.y = 170 - _avatarImage.height;
            if(tempId == 8144)
            {
               _avatarImage.y = -20;
            }
            else if(tempId == 2676)
            {
               _avatarImage.y = -5;
            }
            else if(tempId == 2701)
            {
               _avatarImage.y = -35;
            }
            else if(tempId == 7386)
            {
               _avatarImage.y = -48;
            }
            _avatarImage.visible = true;
         }
         _loc4_ = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onAvatarLoaded);
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_showBtn);
         _showBtn = null;
         ObjectUtils.disposeObject(_avatarImage);
         _avatarImage = null;
         super.dispose();
      }
   }
}

