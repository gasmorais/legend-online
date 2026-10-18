package childspiritexpedition.formation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SpiritExpeditionSkillSelectView extends Component
   {
      
      private static const COLUMN_NUM:int = 4;
      
      private static const ROW_NUM:int = 2;
      
      private var _bg:ScaleBitmapImage;
      
      private var _tileList:SimpleTileList;
      
      private var _callBack:Function;
      
      private var skillList:Vector.<BaseIconView>;
      
      public function SpiritExpeditionSkillSelectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionSkillSelectView.bg");
         _tileList = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionSkillSelectView.SimpleTileList",[4]);
         addChild(_bg);
         addChild(_tileList);
         _bg.mouseChildren = _bg.mouseEnabled = false;
      }
      
      public function show(param1:Array, param2:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:BaseIconView = null;
         _callBack = param2;
         skillList = new Vector.<BaseIconView>();
         _tileList.commitChanges();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionChildSkillItem.skillIcon");
            _loc3_.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            _loc3_.tipData = _loc5_;
            _tileList.addChild(_loc3_);
            skillList.push(_loc3_);
            _loc3_.addEventListener("click",__selectSkillHandler);
            _loc4_++;
         }
         _tileList.beginChanges();
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function __selectSkillHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseIconView = param1.currentTarget as BaseIconView;
         var _loc3_:SkillTempInfo = _loc2_.tipData as SkillTempInfo;
         if(_loc3_ && _callBack != null)
         {
            _callBack(_loc3_);
         }
         dispose();
      }
      
      private function removeSkillIconEvent(param1:DisplayObject) : void
      {
         if(param1)
         {
            param1.removeEventListener("click",__selectSkillHandler);
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         LogicUtils.disposeDisplayCollection(skillList,removeSkillIconEvent);
         skillList = null;
         _callBack = null;
         super.dispose();
      }
   }
}

