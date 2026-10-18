package stelesys.item
{
   import flash.events.MouseEvent;
   import mvc.module.stele.StelesysInfo;
   import yishi.manager.NotificationManager;
   
   public class StelaBackBoxItem extends StelesysMetrialBox
   {
      
      public function StelaBackBoxItem()
      {
         super();
      }
      
      override public function set isChoose(param1:Boolean) : void
      {
         if(_isChoose == param1)
         {
            return;
         }
         _isChoose = param1;
         if(_data)
         {
            _data.isChoose = isChoose;
         }
         _chooseFlg.visible = _isChoose;
         NotificationManager.instance.sendNotification("STELE_SYS_METRIAL",_isChoose ? _data : null);
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
      }
      
      override protected function clickHandler(param1:MouseEvent) : void
      {
         isChoose = !_isChoose;
      }
      
      public function hideChoose() : void
      {
         _isChoose = false;
         if(_data)
         {
            _data.isChoose = _isChoose;
         }
         _chooseFlg.visible = _isChoose;
      }
   }
}

