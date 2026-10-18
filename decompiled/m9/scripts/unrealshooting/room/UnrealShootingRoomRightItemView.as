package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingUserInfo;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class UnrealShootingRoomRightItemView extends Sprite implements Disposeable
   {
      
      private var _indexTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      private var _data:UnrealShootingUserInfo;
      
      public function UnrealShootingRoomRightItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightItemView.indexTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightItemView.nameTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRoomRightItemView.headIcon");
         addChild(_indexTxt);
         addChild(_nameTxt);
         addChild(_headIcon);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_indexTxt);
         _indexTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : UnrealShootingUserInfo
      {
         return _data;
      }
      
      public function set data(param1:UnrealShootingUserInfo) : void
      {
         var _loc3_:VehicleObjectTempInfo = null;
         var _loc2_:String = null;
         _data = param1;
         _indexTxt.visible = false;
         _nameTxt.visible = false;
         _headIcon.visible = false;
         if(data)
         {
            _indexTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRoomRightItemView.indexTxt",data.rank);
            _nameTxt.text = data.nickName;
            _loc3_ = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(data.templateId);
            _loc2_ = "";
            if(_loc3_)
            {
               _loc2_ = PathManager.getVehicleShowAvatarPath(_loc3_.Avatar);
               if(_loc2_ != String(_headIcon.icon))
               {
                  _headIcon.icon = _loc2_;
               }
            }
            _indexTxt.visible = true;
            _nameTxt.visible = true;
            _headIcon.visible = true;
         }
      }
      
      override public function get height() : Number
      {
         return 38;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

