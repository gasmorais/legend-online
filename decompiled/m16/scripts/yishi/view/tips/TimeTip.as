package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class TimeTip extends BaseTip
   {
      
      private var _time:TimePlusView;
      
      public function TimeTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 155;
         _bg.height = 30;
         _time = ComponentFactory.Instance.creatCustomObject("Tips.TimePlusView");
         addChild(_time);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc2_.castle_offset == -1)
         {
            _time.setTimeCount((_data as PlayerModel).sysCurtime);
            return;
         }
         var _loc1_:Date = DateFormatter.getTimezoneOffsetDate(_loc2_.castle_offset);
         _time.setTimeCount(_loc1_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_time);
         _time = null;
      }
   }
}

