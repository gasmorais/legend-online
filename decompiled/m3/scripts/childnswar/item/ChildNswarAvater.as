package childnswar.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.manager.NotificationManager;
   import yishi.utils.FlickerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNswarAvater extends Sprite
   {
      
      private var _hitSp:Sprite;
      
      private var _add:Bitmap;
      
      private var _chidData:ChildData;
      
      private var _bodyHitSp:Sprite;
      
      private var _standImg:ScaleFrameImage;
      
      private var _childAvatar:ChildNswarAvatarLoader;
      
      private var _idx:int;
      
      public function ChildNswarAvater(param1:int)
      {
         super();
         _idx = param1;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _add = ComponentFactory.Instance.creatBitmap("asset.childnswar.team.add");
         _standImg = ComponentFactory.Instance.creatComponentByStylename("ui.chilsnswar.standImg");
         _childAvatar = new ChildNswarAvatarLoader();
         _hitSp = new Sprite();
         _bodyHitSp = new Sprite();
         _bodyHitSp.graphics.beginFill(16711680,0);
         _bodyHitSp.graphics.drawRect(0,0,103,103);
         _bodyHitSp.graphics.endFill();
         addChild(_standImg);
         addChild(_childAvatar);
         addChild(_hitSp);
         addChild(_bodyHitSp);
         _childAvatar.mouseEnabled = _childAvatar.mouseChildren = false;
         _bodyHitSp.mouseEnabled = false;
         this.hitArea = _bodyHitSp;
         _hitSp.addChild(_add);
         _childAvatar.x = 51;
         _childAvatar.y = 112;
         if(_idx > 2)
         {
            _standImg.setFrame(_idx - 2);
         }
         else
         {
            _standImg.setFrame(1);
         }
      }
      
      public function set chidData(param1:ChildData) : void
      {
         _chidData = param1;
         if(_chidData)
         {
            _childAvatar.refresh(_chidData.job,_chidData.growthGrade);
            _hitSp.visible = false;
         }
         else
         {
            _childAvatar.clean();
            _hitSp.visible = true;
         }
      }
      
      public function get chidData() : ChildData
      {
         return _chidData;
      }
      
      private function initEvent() : void
      {
         _hitSp.addEventListener("click",clickHandler);
         this.addEventListener("rollOver",overHandler);
         this.addEventListener("rollOut",outHandler);
      }
      
      private function removeEvent() : void
      {
         _hitSp.removeEventListener("click",clickHandler);
         this.removeEventListener("rollOver",overHandler);
         this.removeEventListener("rollOut",outHandler);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         if(_chidData)
         {
            _hitSp.visible = true;
         }
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         if(_chidData)
         {
            _hitSp.visible = false;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(ChildManager.instance.nsModel.nsList.length);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnswar.need.mainLess"));
            return;
         }
         FlickerHelper.setFlash(_standImg,0.3,0);
         NotificationManager.instance.sendNotification("ChildNswar.Evnet.ShowChooseView",_idx);
      }
      
      public function stopFlash() : void
      {
         FlickerHelper.clearFilcker(_standImg);
      }
      
      public function dispose() : void
      {
         removeEvent();
         FlickerHelper.clearFilcker(_standImg);
         ObjectUtils.disposeObject(_standImg);
         _standImg = null;
         ObjectUtils.disposeObject(_add);
         _add = null;
         ObjectUtils.disposeObject(_childAvatar);
         _childAvatar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _chidData = null;
      }
   }
}

