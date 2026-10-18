package battle.view.bottom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pvp.ChildPvpBattleChildMsg;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class ChildNswarCallIcon extends Sprite
   {
      
      private var _icon:BaseIconView;
      
      private var _mShape:Shape;
      
      private var _dieImg:Bitmap;
      
      private var _fightIng:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _idx:int;
      
      public function ChildNswarCallIcon(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.battle.nswarCicleBg");
         _icon = ComponentFactory.Instance.creatCustomObject("childnswar.battle.childIcon");
         _dieImg = ComponentFactory.Instance.creatBitmap("asset.battle.nswarDie");
         _fightIng = ComponentFactory.Instance.creatBitmap("asset.battle.nswarCicle");
         _mShape = new Shape();
         _mShape.graphics.beginFill(16711680);
         _mShape.graphics.drawCircle(0,0,22);
         _mShape.graphics.endFill();
         _mShape.x = 27.5;
         _mShape.y = 31;
         addChild(_bg);
         addChild(_icon);
         addChild(_mShape);
         addChild(_fightIng);
         addChild(_dieImg);
         _icon.mask = _mShape;
         _dieImg.visible = false;
         _fightIng.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",clickHandler);
         buttonMode = true;
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
         buttonMode = false;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("childnswar.battle.UseAdd",_idx);
      }
      
      public function updateView(param1:ChildPvpBattleChildMsg) : void
      {
         var _loc2_:ChildTempInfo = null;
         if(param1)
         {
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.jobType,1);
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            _icon.tipData = LanguageMgr.GetTranslation("childnswar.click.addRole");
            _dieImg.visible = false;
            _fightIng.visible = false;
            switch(int(param1.state))
            {
               case 0:
                  removeEvent();
                  addEvent();
                  break;
               case 1:
                  _fightIng.visible = true;
                  removeEvent();
                  break;
               case 2:
                  _dieImg.visible = true;
                  removeEvent();
            }
         }
         else
         {
            _dieImg.visible = false;
            _fightIng.visible = false;
            removeEvent();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_fightIng);
         _fightIng = null;
         ObjectUtils.disposeObject(_dieImg);
         _dieImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

