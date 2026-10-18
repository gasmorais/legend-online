package buildings.politics.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import map.internals.constant.MapGrid;
   import map.internals.data.MapInitData;
   import mvc.module.buildings.FieldData;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class FieldItem extends Sprite implements Disposeable
   {
      
      private var _background:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _posText:FilterFrameText;
      
      private var _yieldText:FilterFrameText;
      
      private var _timeDown:TimeDownView;
      
      private var _lookBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _data:FieldData;
      
      public function FieldItem()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("politics.YieldItemBack");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldNameValueText");
         _posText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldPosValueText");
         _yieldText = ComponentFactory.Instance.creatComponentByStylename("politics.FieldYieldValueText");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("politics.FieldLookButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("politics.FieldDeleteButton");
         _timeDown = ComponentFactory.Instance.creatComponentByStylename("politics.TimeDownView");
         addChild(_background);
         addChild(_nameText);
         addChild(_posText);
         addChild(_yieldText);
         addChild(_timeDown);
         addChild(_lookBtn);
         addChild(_deleteBtn);
         _background.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.tipData = LanguageMgr.GetTranslation("buildings.politics.view.FieldItem.lookTipData");
         _deleteBtn.visible = false;
         _deleteBtn.tipData = LanguageMgr.GetTranslation("buildings.politics.view.FieldItem.deleteTipData");
      }
      
      private function initEvent() : void
      {
         _lookBtn.addEventListener("click",__lookHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
      }
      
      private function removeEvent() : void
      {
         _lookBtn.removeEventListener("click",__lookHandler);
         _deleteBtn.removeEventListener("click",__deleteHandler);
      }
      
      protected function __lookHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc4_:MapInitData = new MapInitData();
         _loc4_.mapTempInfo = TempleteManager.instance.mapTemplateCate.getTemplateByID(_data.mapId);
         var _loc2_:int = int(MapGrid.getConvertWidth(int(_data.pos.split(",")[0])));
         var _loc3_:int = int(MapGrid.getConvertWidth(int(_data.pos.split(",")[1])));
         _loc4_.targetPoint = new Point(_loc2_ * 50,_loc3_ * 50);
         SceneManager.instance.setScene("OUTER_CITY_SCENE",_loc4_);
      }
      
      protected function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [giveUpField];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("buildings.politics.view.FieldItem.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function giveUpField(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_data)
            {
               BuildingSocketOutManager.unoccupy(_data.pos);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("buildings.politics.view.FieldItem.content02"));
            }
         }
      }
      
      private function clean() : void
      {
         _nameText.text = "";
         _posText.text = "";
         _yieldText.text = "";
         _timeDown.pause();
         _lookBtn.visible = false;
         _deleteBtn.visible = false;
      }
      
      private function refreshView() : void
      {
         clean();
         if(!_data)
         {
            return;
         }
         if(ArmyManager.instance.thane.grades > 8)
         {
            _lookBtn.visible = true;
         }
         else
         {
            _lookBtn.visible = false;
         }
         _deleteBtn.visible = true;
         _nameText.text = _data.fieldName;
         _posText.text = MapGrid.getPositionString(_data.pos);
         _yieldText.text = _data.yield.toString();
         var _loc1_:Number = Number(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         var _loc2_:Number = Number(_data.createDate.time);
         _loc2_ = _loc1_ * 1000 - _loc2_;
         var _loc3_:Number = Number(_data.refreshTime);
         _loc3_ -= _loc2_ / 1000;
         _loc3_ = _loc3_ < 0 ? 0 : _loc3_;
         _timeDown.timeCount = int(_loc3_);
         _timeDown.start();
      }
      
      public function set data(param1:FieldData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_posText);
         _posText = null;
         ObjectUtils.disposeObject(_yieldText);
         _yieldText = null;
         ObjectUtils.disposeObject(_timeDown);
         _timeDown = null;
         ObjectUtils.disposeObject(_lookBtn);
         _lookBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

